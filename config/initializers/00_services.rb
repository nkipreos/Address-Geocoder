require 'ostruct'
require 'yaml'

if Rails.env.production?
  services_config = YAML.load_file("#{Rails.root}/../../shared/config/services_config.yml")
  env_config = services_config[Rails.env] || {}
  ServicesConfig = OpenStruct.new(env_config)
end
