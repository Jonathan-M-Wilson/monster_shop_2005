RSpec.describe 'As a registered user' do
  before :each do
    @user = User.create!(name: "Bob Vance",
                                  address: "123 ABC St.",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80202",
                                  email: "example@hotmail.com",
                                  password: "qwer",
                                  role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit my profile page and I click on the link to edit my profile data; I see a form like the registration page; The form is prepopulated with all my current information except my password' do
    it 'When I change any or all of that information and submit, I am returned to my profile page, and I see a flash message telling me that my data is updated, and I see my updated information' do

      visit "/profile"
      click_on 'Edit Profile'
      expect(current_path).to eq("/users/edit")

      expect(find_field('Name').value).to eq('Bob Vance')
      expect(find_field('Address').value).to eq('123 ABC St.')
      expect(find_field('City').value).to eq('Denver')
      expect(find_field('State').value).to eq('CO')
      expect(find_field('Zip').value).to eq('80202')
      expect(find_field('Email').value).to eq('example@hotmail.com')

      fill_in :city, with: 'Boulder'
      click_on 'Save Profile'

      expect(current_path).to eq("/profile")
      expect(page).to have_content('Boulder, CO')
    end
  end

  describe 'When I visit my profile page and I click on the link to change my password; I see a form with fields for a new password, and a new password confirmation' do
    it 'When I fill in the same password in both fields; And I submit the form; Then I am returned to my profile page; And I see a flash message telling me that my password is updated' do

      visit "/profile"
      click_on 'Change Password'
      expect(current_path).to eq("/passwords/edit")
    end
  end
end
