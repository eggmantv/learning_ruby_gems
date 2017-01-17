require File.expand_path('../boot', __FILE__)
Bundler.require

Dir["#{File.expand_path("../lib/*/**/**.rb", __FILE__)}"].each { |file| require file }
