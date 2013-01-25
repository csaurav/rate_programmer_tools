require 'spec_helper'

feature "From the home page, a user should be able to search for tools." do

  scenario  "If a user enters a search term and the tool does
not exist, the user should see a message saying so." do

    visit '/'
    fill_in "search_field", with: "NHibernate"
    click_on "Search"
    page.should have_content("No tool was found matching that name")
  end

  scenario "If a user enters a search term and the tool exists, display the
tool in the search results" do

   Tool.create!(name: "NHibernate")
    visit '/'
    fill_in "search_field", with: "NHibernate"
    click_on "Search"
    page.should have_content("NHibernate")
  end
end
