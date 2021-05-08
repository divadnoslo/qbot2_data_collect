%% Qbot2 Post Data Collection 

%**************************************************************************
% Plot Data if Desired

if (D.plot_collected_data == true)
    
    % Accel Data Plot
    figure
    subplot(3,1,1)
    plot(t, accel(:,1), 'r')
    title('Accel X-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('m/s^2')
    grid on
    subplot(3,1,2)
    plot(t, accel(:,2), 'g')
    title('Accel Y-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('m/s^2')
    grid on
    subplot(3,1,3)
    plot(t, accel(:,3), 'b')
    title('Accel Z-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('m/s^2')
    grid on
    
    % Gyro Data Plot
    figure
    subplot(3,1,1)
    plot(t, gyro(:,1) * 180/pi, 'r')
    title('Gyro X-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('deg/s')
    grid on
    subplot(3,1,2)
    plot(t, gyro(:,2) * 180/pi, 'g')
    title('Gyro Y-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('deg/s')
    grid on
    subplot(3,1,3)
    plot(t, gyro(:,3) * 180/pi, 'b')
    title('Gyro Z-Axis')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('deg/s')
    grid on
    
    % Encoder Plots
    figure
    subplot(2,1,1)
    plot(t, odo(:,1), 'g')
    title('Left Wheel Position')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('m')
    grid on
    subplot(2,1,2)
    plot(t, odo(:,2), 'r')
    title('Right Wheel Position')
    xlabel('Time (s)')
    xlim([0 D.t_end])
    ylabel('m')
    grid on
    
    % Show Last Depth Camera Image Taken
    [end_frame, ~] = size(depth);
    xyz = depth2xyz(depth, end_frame, 'high');
    figure
    hold on
    plot3(xyz(1,:), xyz(2,:), xyz(3,:), 'b.')
    title('Last Depth Camera Image Recorded')
    xlabel('X (m)')
    ylabel('Y (m)')
    zlabel('Z (m)')
    grid on
    view([-28 19])
    hold off
    
end

%**************************************************************************
% Saving Results after the Qbot2 Run
D.save_data = input('Save Data from this run [y/n]:  ', 's');

% In case <enter> is hit
if (isempty(D.save_data))
     while (isempty(D.save_data))
         D.save_data = input('Save Data from this run [y/n]:  ', 's');
     end
end

% Saving data into a .mat file
if (D.save_data(1) == 'y' || D.save_data(1) == 'Y')
    
    % Built .mat file
    disp('Example File Name:  <your_name_here>.mat')
    D.file_name = input('Desired File Name:  ', 's');
    D.file = [D.file_name, '.mat'];
    save(D.file, 't', 'odo', 'accel', 'gyro', 'depth')
    
end

%**************************************************************************
% Give Battery Low Warning

if (battery_voltage(end) < 11)
    fprintf('BATTERY LOW! \nConsider Charging Soon!')
end

clear battery_voltage
%**************************************************************************
clear t odo accel gyro depth t_depth cnt_depth D xyz