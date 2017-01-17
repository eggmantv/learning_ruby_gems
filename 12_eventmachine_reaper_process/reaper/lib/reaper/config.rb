require 'yaml'

module Reaper
  class Config

    attr_accessor :env, :configuration, :pid_file

    def initialize opts = {}
      self.env = opts[:env]

      config_file = File.expand_path('../../../config.yml', __FILE__)
      self.configuration = YAML.load_file(config_file)[self.env]
    end

  end

end