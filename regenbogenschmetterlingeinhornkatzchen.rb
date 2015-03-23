#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :version, '0.0.1'
program :description, 'Pllm'

adb_path = "adb-atomic-developer-bundle/components"
centos_adb_path = adb_path+"/centos/centos-with-docker"
rhel_adb_path = adb_path+"/rhel/rhel-with-docker"
vagrant_base_cmd = "vagrant"
dockerfile = File.open("./examples/Dockerfile")

command :new do |c|
  c.syntax = 'cdk new [options]'
  c.summary = 'Create new container' 
  c.description = 'Create directory with container and host configurations'
  c.example 'Create new container configuration with atomic host to deploy', 'cdk new Geablestapler --host rhel-atomic'
  c.option '--name NAME', String, 'Define name of a container'
  c.option '--host TYPE', String, 'Define host to setup to later deployement'
  c.action do |args, options|
    if options.name && options.host
      FileUtils.mkdir_p "#{options.name}/host"
      host_vagrant_file_path = ""
      guest_vagrant_file_path = ""
      
      case options.host
	      when "rhel-atomic"
	        host_vagrant_file_path = rhel_adb_path+'/atomic-docker-host/Vagrantfile'
	        guest_vagrant_file_path = rhel_adb_path+'/sample-dev/Vagrantfile'
        when "rhel-docker"
            host_vagrant_file_path = rhel_adb_path+'/rhel-docker-host/Vagrantfile'
            guest_vagrant_file_path = rhel_adb_path+'/sample-dev/Vagrantfile'
        when "centos-atomic"
            host_vagrant_file_path = centos_adb_path+'/atomic-docker-host/Vagrantfile'
            guest_vagrant_file_path = centos_adb_path+'/sample-dev/Vagrantfile'
        when "centos-docker"
            host_vagrant_file_path = centos_adb_path+'/centos-docker-host/Vagrantfile'
            guest_vagrant_file_path = centos_adb_path+'/sample-dev/Vagrantfile'
      end
      
      FileUtils.cp host_vagrant_file_path, "./#{options.name}/host/"
      say "#{options.host} host Vagrantfile prepared"
      FileUtils.cp guest_vagrant_file_path, "./#{options.name}/"
      say "#{options.name} Guest Vagrantfile prepared"
      if agree "do you want to generate Dockerfile?", false
	      dockerfile.write("./Dockerfile")
      end
    else
     say "You have to specify name and host"  
    end  
  end
end

command :run do |c|
  c.syntax = 'cdk run [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--dir', String, 'Directory with container project'
  c.action do |args, options|
    # Do something or c.when_called Cdk::Commands::List
  dir = options.dir if options.dir
  
  end
end

command :list do |c|
  c.syntax = 'cdk list [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Cdk::Commands::List
  end
end

command :destroy do |c|
  c.syntax = 'cdk destroy [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Cdk::Commands::Destroy
  end

 command :host do |c|
  c.syntax = 'sdc host [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--create', 'Some switch that does something'
  c.option '--delete', 'Some switch that does something'
  c.option '--list', 'Some switch that does something'
  c.action do |args, options|
    if options.list
      say("Your current options:")
      say("rhel-docker, rhel-atomic, centos-docker, centos-atomic")
    end  
    # Do something or c.when_called Cdk::Commands::List
  end
end
  

end

