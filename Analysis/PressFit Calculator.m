clear
clc
% This script is meant to find the hole size I need to drill in the
% aluminum heat block

% Step 1: Find the size of the OD tube when it expands

OD = 0.840; % inches

Lo_steel = pi*OD;

alpha_steel = [12.5*10^-6 10.8*10^-6]; % inches/(inches*F)

HighTempC = 250; %°C
LowTempC = 20; %°C

% convert to °F
HighTempF = HighTempC*(9/5) + 32;
LowTempF = LowTempC*(9/5) + 32;

dT = HighTempF-LowTempF; % °F

dL_steel = alpha_steel.*dT.*Lo_steel;

L1_steel = (Lo_steel + dL_steel);

thermal_exp_steel_diameter = L1_steel./pi;


% This step finds the diameter of the press fit needed for the aluminum
% heat block at temperature
press_tol = -0.001;

Al_notAssumingThermal = OD + press_tol;

% This step converts the thermally expanded aluminum hole and finds the
% diameter at room temp to be machined

alpha_Al = [21*10^-6 24*10^-6]; % Assume the loosest fit?

Lo_Al = (Lo_steel + dL_steel + pi*press_tol) ./ (1 + dT.*alpha_Al);
format short
drill_Al_Diameter = Lo_Al ./ pi;

drill_Al_Diameter(2)
% Increase diameter by 1 thou
