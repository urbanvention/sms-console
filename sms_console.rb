#!/usr/bin/env ruby -w
# sms_console.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.

require 'optparse'
require 'sms'
lib_folder = File.expand_path(File.dirname(__FILE__) + "/lib/")

Dir["#{lib_folder}/*.rb"].each do |file|
  require file
end

options = {}

optparse = OptionParser.new do|opts|
  opts.banner = <<-BANNER
    Usage: sms_console.rb [options] -p person, text
  BANNER

  options[:dryrun] = false
  opts.on( '-d', '--dry-run', "Runs web service as test user" ) do
    options[:dryrun] = true
  end

  options[:verbose] = false
  opts.on( '-v', '--verbose', 'Output more information' ) do
    options[:verbose] = true
  end

  options[:cheap] = false
  opts.on( '-c', '--cheap', 'Sends a cheap sms with random sender' ) do
    options[:cheap] = true
  end

  options[:person] = ""
  opts.on( '-p', '--person NAME', 'NAME with number in Addressbook' ) do |name|
    options[:person] = name
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

# Parse the command-line. Remember there are two forms
# of the parse method. The 'parse' method simply parses
# ARGV, while the 'parse!' method parses ARGV and removes
# any options found there, as well as any parameters for
# the options.
optparse.parse!

raise NoValidPerson if options[:person] == ""
sms       = Sms.new
text      = ARGV.join(" ")
person    = sms.find_person(options[:person])
sms.cheap = true if options[:cheap]
response  = if options[:dryrun]
  sms.send_test_to person, text
else
  sms.send_to person, text
end

if options[:verbose]
  if person
    puts "Person:   #{person.first_name} #{person.last_name}: #{person.mobile_phone.number}"
    puts "Text:     #{text}"
    puts "Account:  User:  #{sms.username} \tPassword:  #{sms.password}"
    puts "Options:  Cheap: #{sms.cheap? ? "true\tSender:    random" : "false\tSender:    " + sms.sender }"
    puts "Length:   #{text.size}"
    puts "Response: #{response}"
  end
end
