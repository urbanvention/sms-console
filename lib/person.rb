# person.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require 'appscript'
class Person
  attr_accessor :first_name, :last_name, :birth_date, :phones, :mobile_phone
  def initialize data
    @first_name = data.first_name.get
    @last_name  = data.last_name.get
    @birth_date = create_birthday_from(data)
    @phones     = create_phones_from(data)
  end

  def mobile_phone?
    !!@mobile_phone
  end

  private
  def create_phones_from data
    result = []
    data.phones.get.each do |phone|
      phone = Phone.new(phone)
      @mobile_phone = phone if phone.mobile?
      result << phone
    end
    result
  end

  def create_birthday_from data
    time = data.birth_date.get
    time.class == Time ? time.strftime("%d.%m.%Y") : nil
  end
end
