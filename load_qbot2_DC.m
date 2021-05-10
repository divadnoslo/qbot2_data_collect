%% Load Qbot2 Data Collection Script 

close all
clear all
clc

%**************************************************************************
% Set Desired (Max) Run Time
%D.t_end = 10;
t_end = 10;
D.Fs = 50;
D.dt = 1 / D.Fs;

%**************************************************************************
% Define Qbot2 Parameters
D.diameter = 0.35; % m
D.radius = D.diameter / 2;

%**************************************************************************
% To use Pre-Built Motion Profile or Keyboard Motor Controls
% You MUST comment/uncomment to corresponding subsystems in Simulink!

D.plot_v_cmds = true;
qbot2_motion_gen;
v_cmds = D.v_cmds;
t_end = D.t_end;
fprintf('Pre-Built Motion Profile Loaded...  \n')

disp('Press the "Monitor & Tune" button in the Simulink Hardware Tab to Begin')
%**************************************************************************
% Open Simulink Model
open('qbot2_data_collection')

%**************************************************************************
% Plot Collected Data Once Complete
D.plot_collected_data = true;