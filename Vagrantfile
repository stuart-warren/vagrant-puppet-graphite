Vagrant::Config.run do |config|

  config.vm.define :graphitea do |graphitea_config|
    graphitea_config.vm.box = "precise64"
    graphitea_config.vm.host_name = "graphitea"
    graphitea_config.vm.network :hostonly, "192.168.10.21"
    FileUtils.mkdir_p(File.join('cache','apt','partial')) unless Dir.exists?(File.join('cache','apt','partial'))
    graphitea_config.vm.share_folder('apt-cache','/var/cache/apt/archives','cache/apt')
    graphitea_config.vm.provision :puppet do  |puppet|
      puppet.manifests_path = "puppet-modules"
      puppet.manifest_file = "base.pp"
      puppet.module_path = "puppet-modules"
    # puppet.options = "--verbose --debug"
    end
  end

end