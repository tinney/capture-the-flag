require "rails_helper"

RSpec.feature "Create Player", type: :feature do
  scenario "A Player can be created" do
    visit "/teams/"
    click_link "New Team"

    fill_in "Name", :with => "Tom & Jerry"
    click_button "Create"

    expect(page).to have_text("Tom & Jerry")

    click_link "Create Player"
    click_button "Create"
    expect(page).to have_text("Location")
  end
end