# addressbook.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require 'appscript'
class Addressbook
  include Appscript

  attr_accessor :current

  def initialize
    @addressbook = app('Address Book')
  end

  def find name
    begin
      Person.new(@addressbook.people[name].get)
    rescue Appscript::CommandError
      nil
    end
  end

  def birth_date
    @addressbook ? @addressbook.birth_date.get : nil
  end

  def size
    @addressbook.people.get.size
  end

  def people
    result = []
    @addressbook.people.get.each do |person|
      result << Person.new(person)
    end
    result
  end

  def groups
    result = []
    @addressbook.groups.get.each do |group|
      result << Group.new(group)
    end
    result
  end
end
