dep 'mesos base' do
  requires ['mesos.dir',
            'essentials.managed',
            'mesos.src']

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
  source "http://mirror.nus.edu.sg/apache/mesos/#{version}/mesos-#{version}.tar.gz"
  
  install { sudo "make install" }
  
end


dep "maven.bin" do
  provides "mvn"
end

