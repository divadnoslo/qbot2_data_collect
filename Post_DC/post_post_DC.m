% Post Data Run
% David Olson

%% Plot Flags
plot_imu_raw = true;
plot_imu_meas = true;
plot_PVA_meas = true;

%% Plot PVA Meas
%**************************************************************************

if (plot_PVA_meas == true)
    
    % Position
    figure
    subplot(3,1,1)
    hold on
    plot(t, r_t__t_b_meas(:,1), 'r')
    title('r^t_t_b_,_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, r_t__t_b_meas(:,2), 'g')
    title('r^t_t_b_,_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, r_t__t_b_meas(:,3), 'b')
    title('r^t_t_b_,_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    hold off
    
    % Velocity
    figure
    subplot(3,1,1)
    hold on
    plot(t, v_t__t_b_meas(:,1), 'r')
    title('v^t_t_b_,_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, v_t__t_b_meas(:,2), 'g')
    title('v^t_t_b_,_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, v_t__t_b_meas(:,3), 'b')
    title('v^t_t_b_,_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold off
    
    % Attitude
    figure
    subplot(3,1,1)
    hold on
    plot(t, psi_t__t_b_meas(:,1) * 180/pi, 'r')
    title('\phi^t_t_b meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('deg')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, psi_t__t_b_meas(:,2) * 180/pi, 'g')
    title('\theta^t_t_b meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('deg')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, psi_t__t_b_meas(:,3) * 180/pi, 'b')
    title('\psi^t_t_b meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('deg')
    grid on
    hold off
    
end

%% IMU Raw Measurement Plotting
%**************************************************************************

if (plot_imu_raw == true)
    
    % Raw Accel Data
    figure
    subplot(3,1,1)
    hold on
    plot(t, accel(:,1), 'r')
    title('accel_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, accel(:,2), 'g')
    title('accel_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, accel(:,3), 'b')
    title('accel_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    
    % Raw Gyro Data
    figure
    subplot(3,1,1)
    hold on
    plot(t, gyro(:,1) * 180/pi, 'r')
    title('gyro_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, gyro(:,2) * 180/pi, 'g')
    title('gyro_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t,gyro(:,3) * 180/pi, 'b')
    title('gyro_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    
end
%*************************************************************************

%% Transfer Alignment Checkout
%*************************************************************************

if (plot_imu_meas == true)
    % Transfer Alignment Check for Accel
    figure
    subplot(3,1,1)
    hold on
    plot(t, f_b__i_b_meas(:,1), 'r')
    title('f^b_i_b_,_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, f_b__i_b_meas(:,2), 'g')
    title('f^b_i_b_,_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, f_b__i_b_meas(:,3), 'b')
    title('f^b_i_b_,_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s^2')
    grid on
    hold off
    
    % Transfer Alignment Check for Gyro
    figure
    subplot(3,1,1)
    hold on
    plot(t, w_b__i_b_meas(:,1) * 180/pi, 'r')
    title('\omega^b_i_b_,_x meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, w_b__i_b_meas(:,2) * 180/pi, 'g')
    title('\omega^b_i_b_,_y meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, w_b__i_b_meas(:,3) * 180/pi, 'b')
    title('\omega^b_i_b_,_z meas')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ/s')
    grid on
    hold off
    
end

%**************************************************************************