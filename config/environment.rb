# bundler requirements
require 'bundler/setup'
Bundler.require(:default, :development)

# gem requirements
require 'open-uri'
require 'json'

# local file requirements
require_relative '../lib/jobfindercontroller.rb'
require_relative '../lib/parser.rb'
require_relative '../lib/job.rb'
require_relative '../lib/user.rb'




