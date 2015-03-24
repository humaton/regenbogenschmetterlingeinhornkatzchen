require "yaml"

class Cdkconfig
  attr_accessor :default_docker_provider, :containers, :vagrant, :default_docker_provider_os, :default_virt_provider

  def initialize(default_provider, default_provider_os = "centos", vagrant = false, default_virt_provider = "virtualbox")
    self.default_docker_provider = default_provider
    self.default_docker_provider_os = default_provider_os
    self.vagrant = vagrant
    self.default_virt_provider = default_virt_provider
    create_config_dir
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
    if File.directory? File.expand_path("~")+"/.cdk" && File.exist?(File.expand_path("~")+"/.cdk/config.yaml")
      true
    else
      false
    end
  end
end