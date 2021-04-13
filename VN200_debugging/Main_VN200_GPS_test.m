% EE 440 Modern Nav
% Test code for the VN200 GPS
%  - Plots Lat, Lon, and height
%
% Author: S. Bruder

clear;                          % Clear all variables from the workspace
close all;                      % Close all windows
clc;                            % "Clean" the command window

% DO NOT change the sample rate for the GPS!!!
Fs = 5;                         % The GPS updates only at 5 Hz
dT = 1/Fs;                      % Sample interval (sec)
nSec = 10;                      % Duration of data collection (sec)
nSamples = Fs*nSec;             % Number of samples to collect (dimless)
fprintf('Collecting data for %2i sec at %d Hz\n\n', nSec, Fs);

[s, SN] = initialize_VN200_GPS(Fs);   % Initialize the VN200

lat = zeros(Fs*nSec,1);         % Initialize the latitude data array: 1 float per sample
lon = zeros(Fs*nSec,1);         % Initialize the longitude data array: 1 float per sample
hb  = zeros(Fs*nSec,1);         % Initialize the height data array: 1 float per sample
t   = zeros(Fs*nSec,1);         % Initialize the time data array: 1 float per sample

 for k=1:nSec*Fs                % Retrieve GPS data from VN200
    [t(k), NumSats, lat(k), lon(k), hb(k)] = read_VN200_GPS(s); % Get VN200 GPS data

    if ~mod(nSamples-k+1,Fs)
        fprintf('Please wait %i more secomds!!!\n', round((nSamples-k+1) / Fs));
    end
 end
 
stop_VN200(s);                  % Terminates the VN200 IMU data transmission

fprintf('\nNumber of Satelites in view = %d\n', NumSats);
t = t - t(1);                   % Subtract start time (start at t = 0 secs)

% Plot the GPS data (in lat, lon, height)
figure('Units', 'normalized','Position', [0.05, 0.05, 0.5, 0.8]);
subplot(3,1,1)
plot(t, lat, 'r');
title('Plot of VN200 GPS Data', 'FontSize', 14);
ylabel('Lat (\circ)')
grid

subplot(3,1,2)
plot(t, lon, 'b');
ylabel('Lon (\circ)')
grid

subplot(3,1,3)
plot(t, hb, 'k');
ylabel('height (m)')
xlabel('Time (sec)');
grid