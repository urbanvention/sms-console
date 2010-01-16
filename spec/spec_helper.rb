# spec_helper.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.

require File.expand_path(File.dirname(__FILE__) + "/../sms.rb")
lib_folder = File.expand_path(File.dirname(__FILE__) + "/../lib/")

Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

Spec::Runner.configure do |config|
  #config.include(Bla) # available in it-blogs only
  # config.extend Defaults
end
