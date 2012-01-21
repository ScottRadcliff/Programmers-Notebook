Given /^I am on the notes page$/ do
  visit new_note_path
end

Given /^I enter a new note$/ do
  fill_in "task", :with => "iterate an array"
  fill_in "note_content", :with => "each.do {something}"
  click_link "Add Code"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
