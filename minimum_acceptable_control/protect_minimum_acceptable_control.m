function [configuration, state_out] = protect_minimum_acceptable_control(state_in, actuator_availability, monitor_fault)
  configuration = true([1 6]);
  state_out = "above_mac";

end

