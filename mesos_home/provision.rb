#!/usr/bin/env ruby -w
require File.join(File.dirname(__FILE__),'cluster_config')

def print_run(cmd)
  puts "Executing (#{cmd})"
  system(cmd)
end



MESOS_CONFIG[:masters].each_with_index do |s,i|
  cmd = "ssh #{s}  \"source /etc/profile; cd /usr/local/mesos;  ruby bin/babushka \\\"mesos master running\\\" \""
  print_run cmd
end


MESOS_CONFIG[:slaves].each_with_index do |s,i|
  cmd = "ssh #{s}  \"source /etc/profile; cd /usr/local/mesos;  ruby bin/babushka \\\"mesos slave running\\\" slave_id=#{i}\""
  print_run cmd
end

# sudo apt-get update
# sudo apt-get install curl


#source /etc/profile ; /usr/local/sbin/mesos-daemon.sh mesos-master --work_dir=/tmp --cluster=mesos-cluster --ip=192.178.0.101 </dev/null >/dev/null
#/usr/local/sbin/mesos-slave --master=192.178.0.101:5050 --hostname=192.178.0.202 --ip=192.178.0.202
#ruby bin/babushka "mesos base"




#ssh 192.178.0.202  "source /etc/profile; cd /usr/local/mesos;  ruby bin/babushka \"mesos slave running\" slave_id=1"
