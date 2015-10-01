feature 'User visits home page' do
  scenario 'they see recently shortened links on the page' do
    FactoryGirl.create(:link, url: "http://google.com")
    FactoryGirl.create(:link, url: "http://yahoo.com")
    FactoryGirl.create(:link, url: "http://ebay.com")

    visit root_path

    expect(page).to have_content('http://google.com')
    expect(page).to have_content('http://yahoo.com')
    expect(page).to have_content('http://ebay.com')
  end
end

feature 'User enters an invalid URL' do
  scenario 'they see a flash error message' do
    visit root_path

    fill_in 'link_url', with: 'INVALID'
    click_button 'Shorten'

    # expect(page).to have_content('http://facebook.com')
    expect(page).to have_selector ".alert", text: "Url must be in a valid format"
  end
end

feature 'User enters a valid URL' do
  scenario 'they see the shortened link on the page' do
    visit root_path

    fill_in 'link_url', with: 'http://facebook.com'
    click_button 'Shorten'

    expect(page).to have_content('http://facebook.com')
  end
end