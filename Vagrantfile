Vagrant::Config.run do |config|

  config.vm.box = "precise32"
  config.vm.box_url = "http://box.puphpet.com/ubuntu-precise12042-x64-vbox43.box"

  config.vm.host_name = "host.parolkar.com"

  config.vm.share_folder("vagrant-root", "/usr/local/mesos", "mesos_home", "nfs" => true,  :mount_options => ["dmode=777","fmode=666"])
  config.ssh.forward_agent = true


  config.vm.define :mesos_master do |master_config|
    
    master_config.vm.network :hostonly, "192.178.0.101"
    master_config.vm.host_name = "mesos-master.parolkar.com"
    
  end

  config.vm.customize ["modifyvm", :id, "--memory", 2048]
  config.vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  
  config.vm.define :mesos_slave_one do |box_config|

    box_config.vm.network :hostonly, "192.178.0.201"
    box_config.vm.host_name = "mesos-slave-one.parolkar.com"

  end
  
  config.vm.define :mesos_slave_two do |box_config|

    box_config.vm.network :hostonly, "192.178.0.202"
    box_config.vm.host_name = "mesos-slave-two.parolkar.com"

  end
  
  config.vm.define :mesos_slave_three do |box_config|

    box_config.vm.network :hostonly, "192.178.0.203"
    box_config.vm.host_name = "mesos-slave-three.parolkar.com"

  end
  
  config.vm.define :mesos_slave_four do |box_config|
    box_config.vm.network :hostonly, "192.178.0.204"
    box_config.vm.host_name = "mesos-slave-four.parolkar.com"
  end

end
