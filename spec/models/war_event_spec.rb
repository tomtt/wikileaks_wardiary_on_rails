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

  describe "tag_with_available_terms" do
    context "with FOO and BAR defined as terms" do
      before do
        Factory.create(:term_definition, :term => "FOO", :pattern => "foo|FOO")
        Factory.create(:term_definition, :term => "BAR", :pattern => "BAR")
      end

      describe "for summary" do
        it "tags an event with terms that match it's summary" do
          war_event = Factory.create(:war_event, :summary => "foo BAR")
          war_event.tag_with_available_terms
          war_event.term_list.should include("FOO", "BAR")
        end

        it "does not tag an event with terms that match part of a word in its summary" do
          war_event = Factory.create(:war_event, :summary => "fool snafoo")
          war_event.tag_with_available_terms
          war_event.term_list.should be_empty
        end
      end

      describe "for title" do
        it "tags an event with terms that match it's title" do
          war_event = Factory.create(:war_event, :title => "foo BAR")
          war_event.tag_with_available_terms
          war_event.term_list.should include("FOO", "BAR")
        end

        it "does not tag an event with terms that match part of a word in its title" do
          war_event = Factory.create(:war_event, :title => "fool snafoo")
          war_event.tag_with_available_terms
          war_event.term_list.should be_empty
        end
      end

      describe "for ccir" do
        it "tags an event with terms that match it's ccir" do
          war_event = Factory.create(:war_event, :ccir => "foo BAR")
          war_event.tag_with_available_terms
          war_event.term_list.should include("FOO", "BAR")
        end

        it "does not tag an event with terms that match part of a word in its ccir" do
          war_event = Factory.create(:war_event, :ccir => "fool snafoo")
          war_event.tag_with_available_terms
          war_event.term_list.should be_empty
        end
      end

      describe "for category" do
        it "tags an event with terms that match it's category" do
          war_event = Factory.create(:war_event, :category => "foo BAR")
          war_event.tag_with_available_terms
          war_event.term_list.should include("FOO", "BAR")
        end

        it "does not tag an event with terms that match part of a word in its category" do
          war_event = Factory.create(:war_event, :category => "fool snafoo")
          war_event.tag_with_available_terms
          war_event.term_list.should be_empty
        end
      end

      it "does not tag an event with terms that don't match any of its fields" do
        war_event = Factory.create(:war_event, :summary => "FOO bar")
        war_event.tag_with_available_terms
        war_event.term_list.should == ["FOO"]
      end

      it "only tags an event once if multiple fields match" do
        war_event = Factory.create(:war_event, :summary => "FOO", :title => "FOO")
        war_event.tag_with_available_terms
        war_event.term_list.should == ["FOO"]
      end

      it "keeps existing taggings" do
        war_event = Factory.create(:war_event, :summary => "FOO", :title => "FOO")
        war_event.term_list = "buzz"
        war_event.tag_with_available_terms
        war_event.term_list.should == ["buzz", "FOO"]
      end

      it "only applies a tag once" do
        war_event = Factory.create(:war_event, :summary => "FOO", :title => "FOO")
        war_event.term_list = "FOO"
        war_event.tag_with_available_terms
        war_event.term_list.should == ["FOO"]
      end

      it "deletes a tag if it no longer applies" do
        war_event = Factory.create(:war_event, :summary => "Nothing here, just BAR")
        war_event.term_list = "FOO, BAR"
        war_event.tag_with_available_terms
        war_event.term_list.should == ["BAR"]
      end
    end
  end

  describe "find_all_by_search_pattern" do
    it "returns only those war events matching the pattern" do
      # The only acceptably efficient way to do this was a MySQL monster, so the test
      # is a bit crude
      we1 = Factory.create(:war_event,
                           :summary => "foo",
                           :title => "",
                           :ccir => "",
                           :category => "")
      we2 = Factory.create(:war_event,
                           :summary => "",
                           :title => "foo",
                           :ccir => "",
                           :category => "")
      we3 = Factory.create(:war_event,
                           :summary => "fool",
                           :title => "",
                           :ccir => "",
                           :category => "")
      we4 = Factory.create(:war_event,
                           :summary => "",
                           :title => "snafoo",
                           :ccir => "",
                           :category => "")
      we5 = Factory.create(:war_event,
                           :summary => "fool fo",
                           :title => "o snafoo",
                           :ccir => "",
                           :category => "")
      we6 = Factory.create(:war_event,
                           :summary => "",
                           :title => "",
                           :ccir => "foo",
                           :category => "")
      we7 = Factory.create(:war_event,
                           :summary => "",
                           :title => "",
                           :category => "foo",
                           :ccir => "")
      we8 = Factory.create(:war_event,
                           :summary => "there's no business like FOO business",
                           :title => "",
                           :ccir => "",
                           :category => "")
      matches = WarEvent.find_all_by_search_pattern!("FOO|foo")
      matches.size.should == 5
      matches.should include(we1, we2, we6, we7, we8)
    end

    it "should work for other databases than MySQL" do
      pending 'Currently only implemented as a MySQL sql atrocity'
    end
  end

  describe "on_date named scope" do
    it "is empty if there are no events" do
      WarEvent.on_date(Date.parse('2008-01-01')).should == []
    end

    it "does not contain an event that starts on the next day" do
      we = Factory.create(:war_event, :date => Date.parse('2008-01-02'))
      WarEvent.on_date(Date.parse('2008-01-01')).should == []
    end

    it "contains an event that starts on that date" do
      we = Factory.create(:war_event, :date => Date.parse('2008-01-01'))
      WarEvent.on_date(Date.parse('2008-01-01')).should == [we]
    end

    it "does not contain an event that starts before that date" do
      we = Factory.create(:war_event, :date => Date.parse('2008-01-01'))
      WarEvent.on_date(Date.parse('2008-01-02')).should == []
    end
  end
end
