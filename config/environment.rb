# bundler requirements
require 'bundler/setup'
Bundler.require(:default, :development)

# gem requirements
require 'pry'
require 'json'
require 'open-uri'
require 'awesome_print'
require 'sanitize'

# local file requirements
require_relative '../lib/jobfindercontroller.rb' # require all files in lib after you've made them!
require_relative '../lib/parser.rb'
require_relative '../lib/job.rb'
require_relative '../lib/user.rb'




