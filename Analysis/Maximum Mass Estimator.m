clc
clear
close all

torque = 0.4; % N-meters
radius = 0.015; % meter, converted from 1.5 cm
gantry_length = 0.345; % meter
% print_speed = [0.03, 0.04, 0.05, 0.06, 0.07, 0.08]; % meter/sec
print_speed = linspace(0.009, 0.2, 10)
force = radius / torque; % newtons

work = force * gantry_length; % joules

travel_time = print_speed ./ gantry_length; % meters per second

power = work * gantry_length; %watts

mass = power./(print_speed * gantry_length); %kg

pounds = mass * 2.205; % convert to pounds

print_speed = print_speed .* 1000;

plot(pounds, print_speed, 'bo', 'MarkerSize',15)
xlabel('Extruder Weight [lbs]')
ylabel('Maximum Print Speed [mm/sec]')
title('Maximum weight for Ender-3 extruder assembly')
x1 = xline(0.24,'r-', {'Current Printhead Mass'}, ...
    'LabelOrientation', 'horizontal');

y1 = yline(100,'b-', {'Maximum Speed Allowed by Firmware'}, ...
    'LabelOrientation', 'horizontal');

figfix()
