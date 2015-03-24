require "yaml"

class Cdkconfig
  attr_accessor :default_docker_provider, :containers, :vagrant,
                :default_docker_provider_os, :default_virt_provider,
                :default_virt_provider,
                :centos_atomic_libvirt, :centos_atomic_vbox


  def initialize(default_provider, default_provider_os = "centos", vagrant = false, default_virt_provider = "virtualbox")
    self.default_docker_provider = default_provider
    self.default_docker_provider_os = default_provider_os
    self.vagrant = vagrant
    self.default_virt_provider = default_virt_provider
    self.centos_atomic_vbox = "http://buildlogs.centos.org/rolling/7/isos/x86_64/CentOS-7-x86_64-AtomicHost-Vagrant-VirtualBox.box"
    self.centos_atomic_libvirt = "http://buildlogs.centos.org/rolling/7/isos/x86_64/CentOS-7-x86_64-AtomicHost-Vagrant-LibVirt-20150228_01.box"
    create_config_dir
  end

  def default_centos_box
    if @default_virt_provider == "libvirt"
      @centos_atomic_libvirt
    else
      @centos_atomic_vbox
    end
  end

  def self.load_config
    YAML.load(File.read(File.expand_path("~")+'/.cdk/config.yaml'))
  end

  def save_config
    File.open(File.expand_path("~")+'/.cdk/config.yaml', 'w') {|f| f.write(YAML.dump(self)) }
    #File.open('/path/to/file.extension', 'w') {|f| f.write(Marshal.dump(m)) }
  end

  def create_config_dir
    unless File.directory? File.expand_path("~")+"/.cdk"
      FileUtils.mkdir_p File.expand_path("~")+"/.cdk"
    end
  end

  def self.config_exists?
    if File.exist?(File.expand_path("~")+"/.cdk/config.yaml") || File.directory?(File.expand_path("~")+"/.cdk")
      true
    else
      false
    end
  end
end