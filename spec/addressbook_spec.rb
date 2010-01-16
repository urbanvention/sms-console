# sms_spec.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require "spec_helper"

describe "Addressbook" do

  before :each do
    @ab = Addressbook.new
  end

  it "should find Jan Riethmayer" do
    @ab.find("Jan Riethmayer")
  end

  it "should have a size" do
    @ab.size.should be > 0
  end

  it "should have people" do
    people = @ab.people
    people.should be_an_instance_of Array
    if people.size > 0
      person = people[0]
      person.should be_an_instance_of Person
    end
  end

  it "should have the same size as people count" do
    @ab.size.should == @ab.people.size
  end

  it "should have groups" do
    groups = @ab.groups
    groups.should be_an_instance_of Array
    if groups.size > 0
      group = groups[0]
      group.should be_an_instance_of Group
    end
  end
end
