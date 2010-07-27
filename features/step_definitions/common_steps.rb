Then /^the URL should be "([^\"]*)"$/ do |url|
  URI.parse(current_url).path.should == url
end

Then /^debugger$/ do
  debugger
  :debugger
end
