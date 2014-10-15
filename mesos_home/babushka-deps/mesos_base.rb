require File.join(File.dirname(__FILE__),'../cluster_config')


dep 'mesos base' do
  requires ['mesos.dir',
            'essentials.managed',
            'mesos.src'.with({:version => '0.19.0'}),
            'mesos profile',
            'mesos instance allocated',
            'mesos ssh access keys placed']
end

dep "mesos.dir" do
  met? {
    "/usr/local/mesos".p.exists?
  }  
  meet {
    shell "mkdir /usr/local/mesos"
    log "created directory."
  }  
end

dep 'essentials.managed' do
  installs {
    via :yum, %w{java-1.6.0-openjdk.x86_64  java-1.6.0-openjdk-devel.x86_64 python python-devel libcurl libcurl-devel } #TODO: Some packages might be missing, refer to  :apt list and find yum substitutes
    via :apt, %w{openjdk-6-jdk   python2.7 python2.7-dev libcurl3 build-essential ant libcurl4-nss-dev python-boto libsasl2-dev}
  }
  provides "java"
end

dep 'mesos.src', :version do
  version.default('0.19.0')
  requires ['mesos.dir',
            'essentials.managed',
            'maven.bin']
  source "http://archive.apache.org/dist/mesos/#{version}/mesos-#{version}.tar.gz"
  
  install { sudo "make install" }
  
end

dep 'mesos profile' do 
  met? {
    "/etc/profile.d/mesos.sh".p.exists?
  }
  meet { 
    ld_path = "export LD_LIBRARY_PATH=\\$LD_LIBRARY_PATH:/usr/local/lib"
    `cat > /etc/profile.d/mesos.sh <<HERE
       #{ld_path}
HERE
    `
  }
end

dep 'mesos instance allocated' do 
  met? {
    "/usr/local/var/mesos/deploy/masters".p.exists? &&  "/usr/local/var/mesos/deploy/slaves".p.exists? 
  }
  meet { 
    masters = MESOS_CONFIG[:masters].join("\n")
    `cat > /usr/local/var/mesos/deploy/masters <<HERE
       #{masters}
HERE
    `
    slaves = MESOS_CONFIG[:slaves].join("\n")
    `cat > /usr/local/var/mesos/deploy/slaves <<HERE
       #{slaves}
HERE
    `
  }
end


dep "maven.bin" do
  provides "mvn"
end



dep "ssh.dir" do
  met? {
    "#{MESOS_CONFIG[:home_folder]}/.ssh".p.exists?
  }
  meet {
    shell "mkdir #{MESOS_CONFIG[:home_folder]}/.ssh"
    log "created directory."
  }
end
 
dep'mesos ssh access keys placed' do  #TODO: Parameterize this, so that key file name can be specified 
  requires ['ssh.dir']
  met? {
    "#{MESOS_CONFIG[:home_folder]}/.ssh/id_rsa".p.exists? &&  "#{MESOS_CONFIG[:home_folder]}/.ssh/authorized_keys".p.exists? 
  }
  meet { 
    `curl "https://gist.githubusercontent.com/parolkar/f9d0f10ed6aae2135095/raw/c45cb37907696bf75ec1279570722fdbc339db95/private-key" -k > #{MESOS_CONFIG[:home_folder]}/.ssh/id_rsa; chmod 600 #{MESOS_CONFIG[:home_folder]}/.ssh/id_rsa`
    `curl "https://gist.githubusercontent.com/parolkar/f9d0f10ed6aae2135095/raw/015e923a6ebd1e62200c273a12e9f2c18009baa8/public-key" -k > #{MESOS_CONFIG[:home_folder]}/.ssh/authorized_keys`
  }
end


dep "mesos master running" do
    requires ['mesos base']
    met? {
      !(`pgrep mesos-master`.strip == "")
    }
    meet {
      master_ip = MESOS_CONFIG[:masters].first
      cmd = "source /etc/profile ; /usr/local/sbin/mesos-daemon.sh mesos-master --work_dir=/tmp --cluster=mesos-cluster --ip=192.178.0.101 </dev/null >/dev/null "
      log("Attempting to execute: #{cmd}")
       `/bin/bash -c "#{cmd}"`
    }
end


dep "mesos slave running" , :slave_id  do
    requires ['mesos base']
    slave_id.default('0')
    met? {
      log("Slave Check: #{`pgrep mesos-slave`.strip}")
      !(` pgrep mesos-slave`.strip == "")
    }
    meet {
       slave_ip = MESOS_CONFIG[:slaves][slave_id.to_s.to_i]
       cmd = "source /etc/profile; /usr/local/sbin/mesos-daemon.sh  mesos-slave --master=#{MESOS_CONFIG[:masters].first}:5050 --hostname=#{slave_ip} --ip=#{slave_ip}"
       log("Attempting to execute: #{cmd}")
      `/bin/bash -c "#{cmd}  </dev/null >/dev/null" `
      log("Slave Started: #{`pgrep mesos-slave`}")
    }
    
end
