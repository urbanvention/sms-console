# sms_spec.rb ;; 2010 (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
require "spec_helper"

describe "Sms" do
  def valid_sms
    ab = Addressbook.new
    sms = Sms.new
    jan = ab.find(Defaults.name)
    sms.username = "Test"
    sms.password = "Test"
    sms.recipient= jan.mobile_phone.number
    sms.sender= jan.mobile_phone.number
    sms.text= "Hello, this is a test sms"
    sms
  end

  describe "that is valid" do
    before :each do
      @sms = valid_sms
    end

    it "should be valid" do
      @sms.valid?.should be_true
    end

    it "should not be valid with wrong url" do
      @sms.url.should == Defaults.url
      @sms.valid?.should be_true
      @sms.url = "http://example.com"
      @sms.valid?.should be_false
    end

    it "should receive ok after successful sending a valid sms" do
      @sms.valid?.should be_true
      @sms.password = "Test"
      @sms.username = "Test"
      response = @sms.send
      response.should match /OK/
    end

    it "should not be valid with wrong password" do
      @sms.valid?.should be_true
      @sms.password = "something wrong"
      @sms.valid?.should be_false
    end

    it "should not be valid with wrong username" do
      @sms.valid?.should be_true
      @sms.username = "something wrong"
      @sms.valid?.should be_false
    end

    it "should have a recipient" do
      @sms.valid?.should be_true
      @sms.recipient.size.should be > 8
    end

    it "should be invalid if text is longer than 160" do
      @sms.valid?.should be_true
      @sms.text = "a" * 160
      @sms.valid?.should be_true
      @sms.text = "a" * 161
      @sms.valid?.should be_false
    end
  end

  describe "that is invalid" do
    def sms_without_recipient
      sms = valid_sms
      sms.recipient = nil
      sms.text= "Hello, this is a test-sms"
      sms
    end

    it "should raise an exception on sending" do
      lambda { sms_without_recipient.send }.should raise_error InvalidMessage
    end
  end

  describe "to a person from address book" do
    it "should find a person" do
      @person = Addressbook.new.find(Defaults.name)
      @person.first_name.size.should be > 0
      @person.last_name.size.should be > 0
    end

    it "should send the sms to the mobile number" do
      @person = Addressbook.new.find(Defaults.name)
      sms = valid_sms
      response = sms.send_to @person, "TestSMS"
      response.should match /OK/
    end

    it "should fail if the person isn't found in the addressbook" do
      @person = Addressbook.new.find(Defaults.not_existing_name)
      sms = valid_sms
      lambda { sms.send_to @person, "Hi stranger!" }.should raise_error NoValidPerson
    end

    it "should fail if the provided name is ambigious" do
      @person = Addressbook.new.find(Defaults.not_existing_name)
      sms = valid_sms
      lambda { sms.send_to @person, "Hi guys!"}.should raise_error NoValidPerson
    end

    it "should fail if the person is found but no mobile phone is provided" do
      @person = Addressbook.new.find(Defaults.without_mobile_phone)
      sms = valid_sms
      lambda { sms.send_to @person, "Hey you without mobile phone!"}.should raise_error NoValidPerson
    end
  end
end
