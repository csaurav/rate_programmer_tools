require 'spec_helper'

feature "From the home page, a user should be able to search for tools." do

  scenario  "If a user enters a search term and the tool does not exist,
the user should see a message saying so.", js: true do

    visit '/'
    fill_in "search_field", with: "NHibernate"
    click_on "Search"
    page.should have_content("No tool was found matching that name")
  end

  scenario "If a user enters a search term and the tool exists,
display the tool in the search results", js: true do

   Tool.create!(name: "NHibernate")
    visit '/'
    fill_in "search_field", with: "NHibernate"
    click_on "Search"
    page.should have_content("NHibernate")
  end

  scenario "If a search term returns more than 15 results, the pager will
only display 15 records and page the rest" do

    20.times do | x |
      Tool.create(name:"theTool#{x}")
    end

    visit '/'
    fill_in "search_field", with: "theTool"
    click_on "Search"
    page.should have_selector(".tool_search_result", count: 15)
  end
end
