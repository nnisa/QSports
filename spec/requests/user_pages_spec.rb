require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    before(:all) { 30.times { FactoryGirl.create(:user) } }
    after(:all)  { User.delete_all }
    
    describe "C grade level" do
      describe "for non-admin users" do
        let(:user) { FactoryGirl.create(:user) }
  
        describe "should send you back to root" do
          before {visit users_path}
          it {should have_selector('title', text: 'The Bands of BandBlitz')}
  
          describe "after signing in as a regular user" do
            before do
              sign_in user
              visit users_path
            end
            it "should send you back to root" do
              page.should have_selector('title', text: 'The Bands of BandBlitz')
            end
          end
        end
      end
    end
    
    describe "A grade level" do
      describe "for admin users" do
        let(:admin) { FactoryGirl.create(:admin) }
        before(:each) do
          sign_in admin
          visit users_path
        end

        it { should have_selector('title', text: 'All users') }
        it { should have_selector('h1',    text: 'Listing Users') }

        describe "pagination" do
          it { should have_selector('div.pagination') }

          it "should list each user" do
            User.paginate(page: 1).each do |user|
              page.should have_selector('td>a', text: user.name)
            end
          end      
        end

        describe "delete links" do
          it { should have_link('delete', href: user_path(User.first)) }
          it "should be able to delete another user" do
            expect { click_link('delete') }.to change(User, :count).by(-1)
          end
          it { should_not have_link('delete', href: user_path(admin)) }
        end
      end
    end
  end

  describe "D grade level" do
    describe "signup page" do
      before { visit signup_path }
      it { should have_selector('title', text: 'Sign up') }
    end

    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { should have_selector('h1',    text: user.name) }
      it { should have_selector('title', text: user.name) }  
    end
  end
  
  describe "signup" do
    
    before { visit signup_path }

    let(:submit) { "Create my account" }
    
    describe "C grade level" do
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_selector('title', text: 'Sign up') }
          it { should have_content('error') }
        end
      end
    end
    
    describe "B grade level" do
      describe "with valid information" do

        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"        
        end
      
        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving a user" do
          before { click_button submit }

          let(:user) { User.find_by_email("user@example.com") }

          it { should have_selector('title', text: user.name) }
          it { should have_selector('div.alert.alert-success', text: 'Welcome') }
          it { should have_link('Logout') }
        end
      end
    end
  end

  describe "C grade level" do
    describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit edit_user_path(user)
      end
  
      describe "page" do
        it { should have_selector('title', text: "Update Profile") }
      end
    
      describe "with invalid information" do
        before { click_button "Update" }
        it { should have_content('error') }
      end
    
      describe "with valid information" do
        let(:new_name) { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          sign_in user
          visit edit_user_path(user)
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirmation", with: user.password
          click_button "Update"
        end

        it { should have_selector('title', text: new_name) }
        it { should have_link('Logout', href: logout_path) }
        it { should have_selector('div.alert.alert-success') }
        specify { user.reload.name.should  == new_name }
        specify { user.reload.email.should == new_email }
      end    
    end
  end
end
