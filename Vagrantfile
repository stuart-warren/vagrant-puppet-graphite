Vagrant::Config.run do |config|

  config.vm.define :graphitea do |graphitea_config|
    graphitea_config.vm.box = "precise64"
    graphitea_config.vm.host_name = "graphitea"
    # Set up your network as you like
    #graphitea_config.vm.network :bridged
    graphitea_config.vm.network :hostonly, "192.168.10.21"
    FileUtils.mkdir_p(File.join('cache','apt','partial')) unless Dir.exists?(File.join('cache','apt','partial'))
    graphitea_config.vm.share_folder('apt-cache','/var/cache/apt/archives','cache/apt')
    # Set the Timezone to something useful
    graphitea_config.vm.provision :shell, :inline => "echo \"Europe/London\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
    graphitea_config.vm.provision :puppet do  |puppet|
      puppet.manifests_path = "puppet-modules"
      puppet.manifest_file = "base.pp"
      puppet.module_path = "puppet-modules"
    # puppet.options = "--verbose --debug"
    end
  end

end
