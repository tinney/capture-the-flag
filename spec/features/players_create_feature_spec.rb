require "rails_helper"

RSpec.feature "Create Player", type: :feature do
  scenario "A Player can be created" do
    team = create(:team, name: 'Red Team')
    visit "/teams/#{team.id}"
    expect(page).to have_text("Red Team")

    click_link "Create Player"
    click_button "Create"
    expect(page).to have_text("Email")
  end
end