RSpec.describe Link do

  it 'generates a token' do
    link = FactoryGirl.create(:link)
    expect(link.token).not_to be_empty
  end

  it 'fails validation if URL is missing' do
    link = FactoryGirl.build(:link, url: "")
    expect(link.valid?).to be false
    expect(link.errors[:url]).to_not be_empty
  end

  it 'fails validation if URL is invalid' do
    link = FactoryGirl.build(:link, url: "INVALID")
    expect(link.valid?).to be false
    expect(link.errors[:url]).to_not be_empty
  end

end