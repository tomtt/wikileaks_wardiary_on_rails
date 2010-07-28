require 'spec_helper'

describe TermDefinition do
  it "has a working factory" do
    Factory.create(:term_definition).should be_valid
  end

  it "has a factory that can create multiple instances" do
    Factory.create :term_definition
    Factory.build(:term_definition).should be_valid
  end

  it "needs term to be present" do
    Factory.build(:term_definition, :term => "").should_not be_valid
  end

  it "needs definition to be present" do
    Factory.build(:term_definition, :definition => "").should_not be_valid
  end

  it "can not have a term longer than 255 characters" do
    Factory.build(:term_definition, :term => "x" * 256).should_not be_valid
  end

  it "can not multiple instances with the same term" do
    Factory.create(:term_definition, :term => "crawling-tiger")
    Factory.build(:term_definition, :term => "crawling-tiger").should_not be_valid
  end
end
