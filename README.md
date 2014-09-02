Babushka-Mesos
==============


  This is very handy, Babushka based provisioning of Mesos Cluster
  
  
  ###Setup
  
 * Get [Vagrant](https://www.vagrantup.com/)
 * Clone this repository (git clone <repo_url> babushka-mesos)
 * $ cd babushka-mesos; 
 * Setup Mesos Master
    * $ vagrant up mesos_master
    * $ vagrant ssh mesos_master
    * (vagrant)$ sudo apt-get update
    * (vagrant)$ sudo apt-get install curl
    * (vagrant)$ sudo sh -c "\` curl https://babushka.me/up \`" #Installing babushka
    * (vagrant)$ cd /usr/local/mesos/
    * (vagrant)$ sudo babushka "mesos base"
 * Setup Mesos Slave
    * $ vagrant up mesos_slave_one
    * $ vagrant ssh mesos_slave_one
    * (vagrant)$ sudo apt-get update
    * (vagrant)$ sudo apt-get install curl
    * (vagrant)$ sudo sh -c "\` curl https://babushka.me/up \`" #Installing babushka
    * (vagrant)$ cd /usr/local/mesos/
    * (vagrant)$ sudo babushka "mesos base"  
 * Run Mesos
    * Append to LD_LIBRARY_PATH (LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib)
    * $mesos-master --help or $mesos-slave --help 
    
    
    
    




-----------------------
Copyright (c) 2014 [Abhishek Parolkar] abhishek[at]parolkar.com , released under the MIT license 
  

