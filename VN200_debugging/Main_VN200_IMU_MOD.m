% EE 440 Modern Nav
% Test code for the VN200 IMU
%  - Plots Gyro, and compass data
%
% Code is modifed to provide only relevent data for our project, and save
% that data for future use.  
%
% Author: S. Bruder
% Modified by D. Olson

clear;                          % Clear all variables from the workspace
close all;                      % Close all windows
clc;                            % "Clean" the command window

Fs = 50;                        % Set Sample frequency <= 100 (Hz)
dT = 1/Fs;                      % Sample interval (sec)
nSec = 120;                      % Duration of data collection (sec)
nSamples = Fs*nSec;             % Number of samples to collect (dimless)
fprintf('Collecting data for %2i sec at %d Hz\n\n', nSec, Fs);

compass = zeros(Fs*nSec, 3);    % Initialize the compass data array: 3 floats per sample
gyro    = zeros(Fs*nSec, 3);    % Initialize the gyro data array: 3 floats per sample
accel   = zeros(Fs*nSec, 3);    % Initialize the accel data array: 3 floats per sample
temp    = zeros(Fs*nSec,1);     % Initialize the temperature data array: 1 float per sample
baro    = zeros(Fs*nSec,1);     % Initialize the Barometric pressure data array: 1 float per sample

[s, SN] = initialize_VN200_IMU( Fs ); % Initialize the VN200

 for k = 1:nSec*Fs              % Retrieve IMU data from VN200
    [compass(k,:), accel(k,:), gyro(k,:), temp(k,:), baro(k,:)] = read_VN200_IMU(s); % Get VN200 IMU data
    if ~mod(nSamples-k+1,Fs)
        fprintf('Please wait %i more seconds!!!\n', round((nSamples-k+1) / Fs));
    end
 end

stop_VN200(s);                  % Terminates the VN200 IMU data transmission

t = 0:dT:(nSamples-1)*dT;       % Time vector (sec)

% Plot the compass data (in Gauss)
figure,
plot(t, compass(:,1), 'r', t, compass(:,2), 'g', t, compass(:,3), 'b');
title('Plot of VN200 Compass Data', 'FontSize', 12);
xlabel('Time (sec)');
ylabel('Magnetic Field (Gauss)')
legend('m_x', 'm_y', 'm_z')
grid

% Plot the Gyro data (in deg/s)
figure,
plot(t, gyro(:,1)*180/pi, 'r', t, gyro(:,2)*180/pi, 'g', t, gyro(:,3)*180/pi, 'b');
title('Plot of VN200 Gyro Data', 'FontSize', 12);
xlabel('Time (sec)');
ylabel('Angular Rate (deg/s)')
legend('\omega_x', '\omega_y', '\omega_z')
grid

% Saving Data for Future Use
% Change variable names to change the name of the .mat files 

save('testData.mat')


