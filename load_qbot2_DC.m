%% Load Qbot2 Data Collection Script 

close all
clear all
clc

addpath('Nav_Functions');

%**************************************************************************
% Set Desired (Max) Run Time
D.t_end = 10 * 60;
D.Fs = 50;
D.dt = 1 / D.Fs;

%**************************************************************************
% Define Qbot2 Parameters
D.diameter = 0.35; % m
D.radius = D.diameter / 2;

%**************************************************************************
% To use Pre-Built Motion Profile or Keyboard Motor Controls
% You MUST comment/uncomment to corresponding subsystems in Simulink!

% Be sure your choice reflects here accordingly
D.use_motion_profile = 0; 

% Load Desired Motion Profile
if (D.use_motion_profile == true)
    D.plot_v_cmds = false;
    qbot2_motion_gen;
    fprintf('Pre-Built Motion Profile Enabled...  \n')
else
    fprintf('Keyboard Motor Controls Enabled...   \n')
%     D.v_cmds = [];
%     D.v_w = zeros(2, length(0 : D.dt : D.t_end));
end

disp('Press the "Monitor & Tune" button in the Simulink Hardware Tab to Begin')
%**************************************************************************
% Open Simulink Model
open('qbot2_data_collection')

%**************************************************************************
% Plot Collected Data Once Complete
D.plot_collected_data = true;