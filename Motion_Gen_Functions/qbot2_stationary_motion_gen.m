%% Stationary Motion Generation Function

function [t_k, r_w, v_w, r_b__t_b, v_b__t_b, a_b__t_b, C_t__b, w_b__t_b] = ...
                     qbot2_stationary_motion_gen(time_pause, P)

t_k = 0 : P.dt : time_pause;                 
r_b__t_b = zeros(3,1,length(t_k));
v_b__t_b = zeros(3,1,length(t_k));
a_b__t_b = zeros(3,1,length(t_k));
w_b__t_b = zeros(3,1,length(t_k));
r_w = zeros(2, length(t_k));
                 
for k = 1 : length(0:P.dt:time_pause)
    C_t__b(:,:,k) = eye(3);
    a_b__t_b(:,k) = zeros(3,1);
end

% build velocity commands
v_w = zeros(2,length(t_k));

end

