%% Qbot2 Post Data Collection 

%**************************************************************************
% Plot Data if Desired

if (D.plot_collected_data == true)
    
    % Show Last Depth Camera Image Taken
    xyz = depth2xyz(depth);
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
    save(D.file, 'depth')
    
end

%**************************************************************************
% Give Battery Low Warning

if (battery_voltage(end) < 11)
    fprintf('BATTERY LOW! \nConsider Charging Soon!')
end

clear battery_voltage
%**************************************************************************
clear t odo accel gyro depth t_depth cnt_depth D xyz