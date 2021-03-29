%% Linear Motion Generation

function [t_k, r_w, v_w, r_b__t_b, v_b__t_b, a_b__t_b, C_t__b, w_b__t_b] = ...
                              qbot2_linear_motion_gen(r_des, P)

dt = P.dt;
                          
% Set Traveling Parameters
v_travel = 0.4; % m/s
a_travel = 3/2; % m/s

% Begin Setting t1
t_travel = r_des / v_travel;
t1 = (pi*v_travel) / (2*a_travel);

% Show Down Travel Parameters if t1 is greater than 1/3 the avg time
while (t1 > ((1/3)*t_travel))
    v_travel = v_travel - 0.05;
    a_travel = a_travel - 0.1;
    
    t_travel = r_des / v_travel;
    t1 = (pi*v_travel) / (2*a_travel);
    
    if ((v_travel <= 0) || (a_travel <= 0))
        error('Requested Distance of Travel too small, v_travel or a_travel is negative')
    end
end

% Compute Distance Covered from 0 < t < t1
t = 0 : dt : t1;
a_l = a_travel*sin((pi/t1)*t);

v_l = zeros(1, length(a_l));
r_l = zeros(1, length(a_l));
for k = 2 : length(a_l)
    v_l(k) = a_l(k)*dt + v_l(k-1);
    r_l(k) = v_l(k)*dt + r_l(k-1);
end

r_t1 = r_l(end);

% How long should t1 < t < t2 be?
r_remain = r_des - (2*r_t1);
t2 = r_remain / v_travel;

if (mod(t2, dt) > 0)
    
    new_t2 = 0;
    while (new_t2 < t2)
        new_t2 = new_t2 + dt;
    end
    t2 = new_t2;
end

% Now actually calculate the entire time of travel

% Build Acceleration Cuve

a_l = [a_travel*sin((pi/t1)*t), zeros(1, length(dt:dt:t2-dt)), -a_travel*sin((pi/t1)*t)];

% Integrate to Velocity and Position
t_k = zeros(1, length(a_l));
v_l = zeros(1, length(a_l));
r_l = zeros(1, length(a_l));

for k = 2 : length(a_l)
    t_k(k) = dt * (k - 1);
    v_l(k) = a_l(k)*dt + v_l(k-1);
    r_l(k) = v_l(k)*dt + r_l(k-1);
end

% Build Function Outputs
r_b__t_b = [r_l; zeros(2,length(t_k))];
v_b__t_b = [v_l; zeros(2,length(t_k))];
a_b__t_b = [a_l; zeros(2,length(t_k))];
for k = 1 : length(t_k)
    C_t__b(:,:,k) = eye(3);
end
w_b__t_b = zeros(3, length(t_k));
r_w = [r_l; r_l];

% build velocity commands
v_w = [v_l; v_l];

end

