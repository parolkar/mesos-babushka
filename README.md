Babushka-Mesos
==============


  This is very handy, [Babushka](http://babushka.me/) based provisioning of Mesos Cluster
  
  
  ###Setup

 Here is a 2 minute guide to bringup mesos cluster on your local computer with 5 VMs


 <iframe src="//player.vimeo.com/video/109466844" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="http://vimeo.com/109466844">2 min guide to mesos setup with vagrant & babushka</a> from <a href="https://github.com/parolkar">@parolkar</a> </p>
  
 * Get [Vagrant](https://www.vagrantup.com/)
 * Clone this repository (git clone <repo_url> babushka-mesos)
 * $ cd babushka-mesos; 
 * $ vagrant up #this will bring up 5 VMs
 * Setup Mesos master & all slaves dependencies
    * $ vagrant ssh mesos_master
    * (vagrant)$ sudo apt-get update
    * (vagrant)$ cd /usr/local/mesos/
    * (vagrant)$ sudo -s
    * (vagrant)# ruby provision.rb        #This will do all magic & may take few minutes based on your network
 * visit http://192.178.0.101:5050 to see Mesos Dashboard


  

-----------------------
Copyright (c) 2014 [Abhishek Parolkar] abhishek[at]parolkar.com , released under the MIT license 
  

