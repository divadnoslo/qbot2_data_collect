% init_qbot2_params.m

% Load all paramters regarding the simulation to the workspace
    
%% Qbot 2 Simulation Model Parameters
P.fidelity = 1;             % Tan_Mech Attitude Update Parameter 
                            % (0 for low fidelity, 1 for high fidelity)

%% Qbot 2 Physical Specs (from datasheet)
P.mass = 4.5; % kg
P.diameter = 0.35; % m
P.radius = P.diameter / 2;
P.max_speed = 0.7;  % m/s

% Odometry Parameters
P.wheel_circumfrence = 0.22037; % m
P.wheel_radius = 0.03507;       % m
% P.ticks2wheelRev = 2578.33;     % ratio
% P.theta_tick = (2*pi)/P.ticks2wheelRev;  % rad
P.sigma_angle = 2 * pi/180;     % std-dev of angle of wheel
P.sigma_odo_d = P.sigma_angle * P.wheel_radius; % m
P.odo_error_flag = true;  % toggle to turn on/off odometry error sources

% Complimentary Filter Constants
w_c = 2.5 * (2*pi);  % rad/s
lpf = tf([w_c], [1 w_c]);
lpf_d = c2d(lpf, P.dt, 'tustin');
P.lpf_num_1 = lpf_d.Numerator{1}(1);
P.lpf_num_2 = lpf_d.Numerator{1}(2);
P.lpf_den_1 = lpf_d.Denominator{1}(2);
clear w_c lpf lpf_d

%% Qbot 2 Depth Sensor Range
P.min_range = 0.5; % m
P.max_range = 6; % m

%% Earth Characteristics (WGS-84 Values)
P.w_ie = 72.92115167e-6;                   % Earth's rotational rate (rad/s)
P.w_i__i_e = [0; 0; P.w_ie];               % Angular velocity of {e} wrt {i} resolved in {i} (rad/s)
P.Ohm_i__i_e = [0,      -P.w_ie, 0; ...         % Skew symmetric version of w_i__i_e (rad/s)
                P.w_ie,  0,      0; ...
                0,       0,      0];
P.mu = 3.986004418e14;      % Earth's gravitational constant (m^3/s^2)
P.J2 = 1.082627e-3;         % Earth's second gravitational constant
P.R0 = 6378137.0;           % Earth's equatorial radius (meters)
P.Rp = 6356752.314245;      % Earth's polar radius (meters)
P.e = 0.0818191908425;      % Eccentricity
P.f = 1 / 298.257223563;    % Flattening


%% From ECEF to Tangential Frame (lat/long are from ERAU King Building, Room 122)

P.L_b = 34.6144991 * pi/180;          % rad
P.lambda_b = -112.4508738 * pi/180;   % rad
P.h_b = 1585; % m
P.R_N = (P.R0*(1 - P.e^2)) / ((1 - P.e^2*sin(P.L_b)^2)^3/2);  % m
P.R_E = P.R0 / sqrt(1 - P.e^2*sin(P.L_b)^2);
P.C_e__n = Lat_Lon_2C_e__n(P.L_b, P.lambda_b);                      
P.C_n__t = eye(3); % Subject to change
P.C_e__t = P.C_e__n * P.C_n__t;
P.r_e__e_t = [(P.R_E + P.h_b)*cos(P.L_b)*cos(P.lambda_b); ...
              (P.R_E + P.h_b)*cos(P.L_b)*sin(P.lambda_b); ...  
              (P.R_E*(1 - P.e^2) + P.h_b) * sin(P.L_b)];
P.Ohm_t__i_e = P.C_e__t' * P.Ohm_i__i_e * P.C_e__t;

%% Gravity Vector
P.g_n__bD = [0; 0; gravity(P.L_b, P.h_b, P)];          % Compute the acceleration due to gravity
P.g_e__b = P.C_e__n * P.g_n__bD;                       % Compute the gravity of the body in the {e} frame
P.g_t__b = P.C_e__t' * P.g_e__b;                       % Compute the gravity of the body in the {t} frame

%% Fake Aiding Sensor Parameters
P.fake_sigma_r = 0.5 * ones(3,1);
P.fake_sigma_v = 0.1 * ones(3,1);
P.fake_sigma_a = 1 * pi/180 * ones(3,1);


