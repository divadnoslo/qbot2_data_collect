%% Qbot 2 Motion Plan

% 3 Modes of Travel
% 'Mode 1' = stationary -> amount of time paused (sec)
% 'Mode 2' = angular    -> amount of angle psi to turn (rad) (NED Frame)
% 'Mode 3' = linear     -> distance forward to drive (meters)

% % Staying Still for an amount of time
% P.motion_plan = {"Mode 1", 10};

% Clock Wise Box
D.motion_plan = {"Mode 3", 1; ...
                 "Mode 2", pi/2; ...
                 "Mode 3", 1; ...
                 "Mode 2", pi/2; ...
                 "Mode 3", 1; ...
                 "Mode 2", pi/2; ...
                 "Mode 3", 1; ...
                 "Mode 2", pi/2};

% % Counter Clock Wise Box
% P.motion_plan = {"Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2};
             
% % King Building Hallway Mock-up
% P.motion_plan = {"Mode 3",     2; ...
%                  "Mode 2",     pi/4; ...
%                  "Mode 3",     sqrt(0.5^2 + 0.5^2); ...
%                  "Mode 2",     pi/4;...
%                  "Mode 3",     1; ...
%                  "Mode 2",     pi/2; ...
%                  "Mode 3",     2.5; ...
%                  "Mode 2",     pi/2; ...
%                  "Mode 3",     1.5};
             
%% Build Motion Plan
% Variables to Consider

[num_steps, ~] = size(D.motion_plan);
r_t__t_b_old = [0; 0; 0];
C_t__b_old = eye(3);
r_wheel_old = [0; 0];
v_wheel = zeros(2,1);

for ii = 1 : num_steps
    
    % Generate body frame motion according to mode of travel
    if (D.motion_plan{ii,1} == "Mode 1")
        [t_k, r_w, v_w, r_b__t_b, v_b__t_b, a_b__t_b, C_b__b_1, w_b__t_b] = ...
           qbot2_stationary_motion_gen(D.motion_plan{ii,2}, D);
    elseif (D.motion_plan{ii,1} == "Mode 2")
        [t_k, r_w, v_w, r_b__t_b, v_b__t_b, a_b__t_b, C_b__b_1, w_b__t_b] = ...
              qbot2_angular_motion_gen(D.motion_plan{ii,2}, D);
    elseif (D.motion_plan{ii,1} == "Mode 3")
        [t_k, r_w, v_w, r_b__t_b, v_b__t_b, a_b__t_b, C_b__b_1, w_b__t_b] = ...
               qbot2_linear_motion_gen(D.motion_plan{ii,2}, D);
    else
        error('Mode of Motion not recognized, check your spelling')
    end
    
    % Build Corect indexes and time vectors
    if (ii == 1)
        t = t_k;
        k = 1 : length(t_k);
        k_next = k;
        k_prev = 0;
    else
        k_prev = k(end);
        k_next = k_prev + (1 : length(t_k));
        k = [k, k_next];
        t = [t, (t(end) + D.dt + t_k)];
    end
    
    % Bring Body Motions into the Tangential Frame
    for jj = k_next
        C_t__b(:,:,jj) = C_b__b_1(:,:,jj-k_prev) * C_t__b_old;
        a_t__t_b(1:3,jj) = C_t__b(:,:,jj) * a_b__t_b(:,jj-k_prev);
        v_t__t_b(1:3,jj) = C_t__b(:,:,jj) * v_b__t_b(:,jj-k_prev);
        r_t__t_b(1:3,jj) = C_t__b(:,:,jj) * r_b__t_b(:,jj-k_prev) + r_t__t_b_old;
        w_t__t_b(1:3,jj) = C_t__b(:,:,jj) * w_b__t_b(:,jj-k_prev);
        r_wheel(1:2,jj)  = r_w(:,jj-k_prev) + r_wheel_old;
        v_wheel(1:2,jj) = v_w(:,jj-k_prev);
        
        % Passing Mode
        if (D.motion_plan{ii,1} == "Mode 1")
            mode(jj) = 1;
        elseif (D.motion_plan{ii,1} == "Mode 2")
            mode(jj) = 2;
        elseif (D.motion_plan{ii,1} == "Mode 3")
            mode(jj) = 3;
        end
    end
    
    % Capture End State for next instruction
    C_t__b_old = C_t__b(:,:,k_next(end));
    r_t__t_b_old = r_t__t_b(:,k_next(end));
    r_wheel_old = [r_wheel(1,end); r_wheel(2,end)];
    
end

%% Save Results into Structure P

D.v_cmds = v_wheel;
% D.ind = k;
% D.r_t__t_b = r_t__t_b;
% D.v_t__t_b = v_t__t_b;
% D.a_t__t_b = a_t__t_b;
% D.C_t__b = C_t__b;
% D.w_t__t_b = w_t__t_b;
% D.t_end = t(end);
% D.r_wheel = r_wheel;
% D.mode = mode;
    
%% Plot Velocity Commands

if (D.plot_v_cmds == true)
    
    figure
    subplot(2,1,1)
    plot(t, D.v_cmds(1,:), 'g')
    title('Left Wheel Velocity Commands')
    ylabel('v_l (m/s)')
    grid on
    subplot(2,1,2)
    plot(t, D.v_cmds(2,:), 'r')
    title('Right Wheel Velocity Commands')
    ylabel('v_r (m/s)')
    xlabel('Time (s)')
    grid on

end

%% Clear unneeded variables from the workspace

clear a_b__t_b a_t__t_b C_b__b_1 C_t__b C_t__b_old ii jj k k_next k_prev kk 
clear num_steps plot_motion_flag r_b__t_b r_t__t_b r_t__t_b_old t t_k
clear v_b__t_b v_t__t_b w_b__t_b w_t__t_b yaw ans C_v__t r_v__t_b r_w
clear r_wheel r_wheel_old mode
D = rmfield(D, 'motion_plan');

clear k r_t__t_b v_t__t_b a_t__t_b C_t__b w_t__t_b t r_wheel mode v_w v_wheel





