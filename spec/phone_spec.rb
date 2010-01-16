# phone_spec.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require 'spec_helper'

describe Phone do

  before :each do
    ab = Addressbook.new
    phones = ab.find("Jan Riethmayer").phones
    @phone = phones[0]
  end

  it "should have a number" do
    @phone.number.should == "+4917648500300"
  end

  it "should have a label" do
    @phone.label.should == "mobile"
  end

  it "should tell wether it's a mobile_phone_number" do
    @phone.mobile?
  end

end
