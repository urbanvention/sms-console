# person_spec.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require "spec_helper"

describe Person do
  describe "with mobile phone number" do
  before :each do
    ab = Addressbook.new
      @person = ab.find(Defaults.name)
    end

    it "should have a firstname" do
      @person.first_name.should == Defaults.name.split(" ").first
    end

    it "should have a lastname" do
      @person.last_name.should == Defaults.name.split(" ").last
    end

    it "should have a birth date" do
      @person.birth_date.should == Defaults.birth_date
    end

    it "should have phone numbers" do
      phone_numbers = @person.phones
      phone_numbers.should be_an_instance_of Array
      if phone_numbers.size > 0
        phone_numbers.each do |phone|
          phone.class.should == Phone
        end
      end
    end

    it "should have a mobile phone number" do
      @person.mobile_phone?.should be_true
      @person.mobile_phone.number.should == Defaults.number
    end
  end
end
