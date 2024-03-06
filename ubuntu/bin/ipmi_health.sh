#!/usr/bin/env bash

sensors_data=$(ipmitool sensor list)

print_error () {
  echo $1
  ipmitool sensor list
  exit 1
}

ipmi_value () {
  grep "$1" <<< $sensors_data | awk -F '|' '{print $2}' | tr -d ' ' | cut -d'.' -f1
}

for sensor in "CPU Temp" "FAN1" "FANA" "FANB"; do
  sensor_status=$(grep "$sensor" <<< $sensors_data | awk -F '|' '{print $4}')
  if test $sensor_status != "ok" && test $sensor_status != "na"; then
    print_error "IPMI reports sensor error"
  fi
done

cpu_temp=$(ipmi_value "CPU Temp")
if test "$cpu_temp" = "na"; then
  # for some reason, sometimes IPMI reports CPU temperature as "na"
  sleep 1
  sensors_data=$(ipmitool sensor list)
  cpu_temp=$(ipmi_value "CPU Temp")
fi
if test $cpu_temp -ge 50; then
  print_error "CPU temperature is above the maximum ($cpu_temp°C)"
fi

cpu_fan_rpm=$(ipmi_value "FAN1")
case_fan1_rpm=$(ipmi_value "FANA")
case_fan2_rpm=$(ipmi_value "FANB")
if test $cpu_fan_rpm -le 500 || test $cpu_fan_rpm -ge 2000; then
  print_error "CPU fan speed is out of bounds ($cpu_fan_rpm RPM)"
elif test $case_fan1_rpm -le 500 || test $case_fan1_rpm -ge 1400; then
  print_error "Case fan 1 speed is out of bounds ($case_fan1_rpm RPM)"
elif test $case_fan2_rpm -le 500 || test $case_fan2_rpm -ge 1400; then
  print_error "Case fan 2 speed is out of bounds ($case_fan2_rpm RPM)"
fi

printf "CPU: %s°C, fans: %s (CPU), %s (A), %s (B)\n" $cpu_temp $cpu_fan_rpm $case_fan1_rpm $case_fan2_rpm
