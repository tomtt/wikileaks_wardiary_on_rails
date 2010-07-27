require 'spec_helper'

describe WarEvent do
  it "has a working factory" do
    Factory.create(:war_event).should be_valid
  end

  it "has a factory that can create multiple instances" do
    Factory.create :war_event
    Factory.build(:war_event).should be_valid
  end

  it "has 30 items per page" do
    WarEvent.per_page.should == 30
  end

  describe "to_param" do
    it "is the report_key" do
      war_event = Factory.create(:war_event, :report_key => "fluffy-bunny")
      war_event.to_param.should == "fluffy-bunny"
    end
  end

  describe "the report_key" do
    it "is unique" do
      Factory.create(:war_event, :report_key => "cuddly-bear")
      Factory.build(:war_event, :report_key => "cuddly-bear").should_not be_valid
    end

    it "can be 255 chars in size" do
      Factory.build(:war_event, :report_key => "x" * 255).should be_valid
    end

    it "can not be 256 chars in size" do
      Factory.build(:war_event, :report_key => "x" * 256).should_not be_valid
    end

    it "can not be NULL in the database" do
      lambda { Factory.create(:war_event, :report_key => nil) }.should raise_error
    end

    it "can not be an empty string" do
      Factory.build(:war_event, :report_key => "").should_not be_valid
    end
  end
end
