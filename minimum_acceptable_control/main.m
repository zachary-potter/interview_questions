clear
clc

% rule 1: availability takes priority over monitors
% rule 2: once failure is identified do not reconfigure
% rule 3: if below minimum acceptable control, use everything

%% test 1
monitor_fault_time_series = [ 0 0 0 0 0 0
                              1 0 0 0 0 0
                              1 0 0 0 0 0
                              1 0 0 0 0 0];

actuator_availability_time_series = [ 1 1 1 1 1 1
                                      1 1 1 1 1 1
                                      1 1 1 1 1 1
                                      1 1 1 1 1 1];

expected_configuration = [ 1 1 1 1 1 1
                           0 1 1 0 1 1
                           0 1 1 0 1 1
                           0 1 1 0 1 1];

%% test 2
% monitor_fault_time_series = [ 0 0 0 0 0 0
%                               0 0 0 0 0 0
%                               0 1 0 0 0 0
%                               0 1 0 0 0 0];
% 
% actuator_availability_time_series = [ 1 1 1 1 1 1
%                                       0 1 1 1 1 1
%                                       0 1 1 1 1 1
%                                       0 0 1 1 1 1];
% 
% expected_configuration = [ 1 1 1 1 1 1
%                            0 1 1 0 1 1
%                            0 1 1 0 1 1
%                            1 1 1 1 1 1];

%% test 3
% monitor_fault_time_series = [ 0 0 0 0 0 0
%                               0 0 0 0 0 0
%                               0 1 0 0 0 0
%                               0 1 0 0 0 0];
% 
% actuator_availability_time_series = [ 1 1 1 1 1 1
%                                       0 1 1 1 1 1
%                                       1 1 1 1 1 1
%                                       0 0 1 1 1 1];
% 
% expected_configuration = [ 1 1 1 1 1 1
%                            0 1 1 0 1 1
%                            0 1 1 0 1 1
%                            1 1 1 1 1 1];


%% step
assert(all(size(actuator_availability_time_series) == size(monitor_fault_time_series)));

state = "above_mac";
for ii = 1:size(actuator_availability_time_series, 1)
  [failure_inhibit_time_series(ii,:), state] = protect_minimum_acceptable_control(state, logical(actuator_availability_time_series(ii,:)), logical(monitor_fault_time_series(ii,:)));
end

if all(all(failure_inhibit_time_series == expected_configuration))
  disp("test pass!")
else
  disp("expect")
  disp(expected_configuration)
  disp("but getting")
  disp(failure_inhibit_time_series)
end











