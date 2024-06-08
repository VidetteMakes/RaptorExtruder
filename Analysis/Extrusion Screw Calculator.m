clc
clear all
close all

%% Calculating maximum Pellet Diameter


%% Key parameters
elastic_tensile_strength_Al = 90; % MPa

pellet_diameter = 10/1000; %m
max_motor_torque = 0.4*5; %Nm, 5:1 gearbox

root_diameter = 5/1000; %m
dr = root_diameter;
outer_diameter = root_diameter + (pellet_diameter*2);
d = outer_diameter;

number_of_threads = 1; %6 is maxumum necessary number, reduce if possible
nt = number_of_threads;

T = max_motor_torque; %Nm torque of motor
n = 1/100; %4.5/100; %efficiency
F = 9.5; %N of downward force

Lead = (2*pi*n*T)/F; %m
P = Lead; %Single start design, pitch is equal to lead
Pitch = P*1000

thread_thickness = (P-pellet_diameter)*1000 % How thin can this be before the machinist says no?
tt = (P-pellet_diameter);

axial = (-4*F)/(pi*dr^2);
bending = (3*F*(d-dr)*tt)/(nt*pi*dr*(tt^3));
shear = (2*T)/(pi*(dr^2)*tt*nt);
torsion = (T*(d/2))/((pi/32)*(d^4));

sig_y = axial;
sig_x = bending;
sig_z = 0;
tau_zx = shear;
tau_yz = torsion;
tau_xy = 0;

% verifying the von_mises formula with the example provided by Less Boring
% Lectures
% sig_y = -11.1;
% sig_x = 37.8;
% sig_z = 0;
% tau_zx = 5.04;
% tau_yz = 8.84;
% tau_xy = 0;

von_mises = (1/sqrt(2)) * ((sig_x - sig_y)^2 + (sig_y - sig_z)^2 + (sig_z - sig_x)^2 + 6*(tau_xy^2 + tau_yz^2 + tau_zx^2))^(1/2);
principle_stess_megapascals = von_mises / 1E6;

FOS = elastic_tensile_strength_Al / principle_stess_megapascals

