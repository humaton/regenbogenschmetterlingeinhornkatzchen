class Config
  attr_accessor :default_docker_provider, :containers, :vagrant

  def new(default_provider, vagrant = false)
    self.default_docker_provider = default_provider
    self.vagrant = vagrant
  end

  def load_config

  end

  def save_config

  end
end