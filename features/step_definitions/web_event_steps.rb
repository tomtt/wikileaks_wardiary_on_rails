Given /^(\d+) war events exist numbered with the category "([^\"]*)"$/ do |count, category|
  count.to_i.times do  |i|
    Factory.create(:war_event, :category => category.sub("#n", (i + 1).to_s))
  end
end
