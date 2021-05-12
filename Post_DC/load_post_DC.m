% Configuration for Post-Processing Simulink Files
% David Olson

% Prepare for Data Run
close all
clear all
clc

% Load Data Desired for Run
load('dummy.mat')
P.t = t;
P.accel = accel;
P.gyro = gyro;
P.odo = odo;
P.depth = depth;

% Load Tranfer Alignment Calibrations
load('Trans_Cal.mat')
P.b_a_FB = b_a_FB;
P.b_g_FB = b_g_FB;
P.M_a = M_a;
P.M_g = M_g;

% Add needed files to search path
addpath('Nav_Functions')

% Specify Model Characteristics
P.Fs  = 50;                 % Sample frequency (Hz)
P.dt  = 1/P.Fs;             % Sample interval (sec)
P.t_start = 0;              % Simulation start time (sec)
P.t_end = t(end);           % Simulation end time (sec)

% Load Qbot 2 Params (Same as Simulation)
init_qbot2_params;

% Open the Simulink File
open('post_data_run')

% Inform User the Data Load is Complete
fprintf('Collected Data has been loaded, run the Simulink file for results \n\n')

