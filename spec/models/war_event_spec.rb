require 'spec_helper'

describe WarEvent do
  before(:each) do
    @valid_attributes = {
      :report_key => "value for report_key",
      :type_of_event => "value for type_of_event",
      :category => "value for category",
      :tracking_number => "value for tracking_number",
      :region => "value for region",
      :attack_on => "value for attack_on",
      :complex_attack => "value for complex_attack",
      :reporting_unit => "value for reporting_unit",
      :unit_name => "value for unit_name",
      :type_of_unit => "value for type_of_unit",
      :mgrs => "value for mgrs",
      :latitude => "value for latitude",
      :longitude => "value for longitude",
      :originator_group => "value for originator_group",
      :updated_by_group => "value for updated_by_group",
      :ccir => "value for ccir",
      :sigact => "value for sigact",
      :affiliation => "value for affiliation",
      :d_color => "value for d_color",
      :classification => "value for classification",
      :title => "value for title",
      :summary => "value for summary",
      :friendly_wia => 1,
      :friendly_kia => 1,
      :host_nation_wia => 1,
      :host_nation_kia => 1,
      :civilian_wia => 1,
      :civilian_kia => 1,
      :enemy_wia => 1,
      :enemy_kia => 1,
      :enemy_detained => 1,
      :date => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    WarEvent.create!(@valid_attributes)
  end

  it "has 30 items per page" do
    WarEvent.per_page.should == 30
  end
end
