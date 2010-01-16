# sms.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
# RestClient.post 'http://soap.smscreator.de/send.asmx/SendSimpleSMS4',
# { "USER" => "RISMSC15186508", "PASS" => "PG7V75", "VON" => "004917648500300",
#   "AN"   => "017648500300",   "TEXT" => "noch ein Test" }
require 'rubygems'
require 'rest_client'
require 'appscript'

class Sms
  attr_accessor :password, :username, :recipient, :cheap
  attr_accessor :sender, :text, :url, :defaults

  def initialize
    load_defaults
  end

  def params
    { "USER" => @username,
      "PASS" => @password,
      "VON"  => @sender,
      "AN"   => @recipient,
      "TEXT" => @text }
  end

  def send
    if valid?
      @sender = nil if cheap?
      RestClient.post url, params
    else
      raise InvalidMessage
    end
  end

  def send_to person, text
    if person && person.mobile_phone?
      @recipient= person.mobile_phone.number
      @text = text
      send
    else
      raise NoValidPerson unless person
      raise NoMobilePhoneNumber unless person.mobile?
    end
  end

  def send_test_to person, text
    @username = "Test"
    @password = "Test"
    send_to person, text
  end

  def valid?
    (@password  == Defaults.password || @password == "Test") &&
    (@username  == Defaults.username || @username == "Test") &&
    @url        == Defaults.url &&
    @recipient  && @recipient.size > 8 &&
    @text       && @text.size > 0 && @text.size < 161
  end

  # address book specific stuff
  def find_person name
    address_book.find(name)
  end

  def cheap?
    @cheap
  end

  private

  def address_book
    @address_book ||= Addressbook.new
  end

  def load_defaults
    @url       = Defaults.url
    @password  = Defaults.password
    @username  = Defaults.username
    @cheap     = false
    @sender    = Defaults.number
  end
end

