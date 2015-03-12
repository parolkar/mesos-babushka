Babushka-Mesos
==============

[![Join the chat at https://gitter.im/parolkar/mesos-babushka](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/parolkar/mesos-babushka?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


  This is very handy, [Babushka](http://babushka.me/) based provisioning of Mesos Cluster
  
  
###Setup

 Here is a 2 minute screencast to bring-up mesos cluster on your computer with 5 VMs


 <p><a href="http://vimeo.com/109466844" target="_blank_"><img src="https://i.vimeocdn.com/video/493425314_300x168.jpg"><br> 2 min guide to mesos setup with vagrant & babushka</a> from <a href="https://github.com/parolkar">@parolkar</a> </p>
 
 
####Steps
 
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


  
####Bonus Tips

 * You could use this to provision cluster in Docker, AWS, RackSpace, DigitalOcean etc. Check [Vagrant providers](https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins#providers)
 * To customize configuration, look at cluster_config.rb and babushka-deps.

####Ideas? What can I do with this provisioning?

 * You can quickly build and demonstrate potential of mesos. Example, [building resilient web infrastructure with Vulcanproxy, wordpress, MariaDB Galera Cluster & Marathon (2 min video)](http://vimeo.com/110914075). 

  

-----------------------
Copyright (c) 2014 [Abhishek Parolkar] abhishek[at]parolkar.com , released under the MIT license 
  

