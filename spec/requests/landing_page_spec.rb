require 'spec_helper'

describe "Landing Page" do

  subject { page }
  
  #Set up the 'world' for testing
  before(:all) do
    @manager1 = User.create(name: "Manager1", email: "manager1@bandblitz.com", password: "tartans", password_confirmation: "tartans")
    @manager2 = User.create(name: "Manager2", email: "manager2@bandblitz.com", password: "tartans", password_confirmation: "tartans")
    @genre1 = Genre.create(name: "Genre1")
    @genre2 = Genre.create(name: "Genre2")
    @genre3 = Genre.create(name: "Genre3")
    @genre4 = Genre.create(name: "Genre4")
    @genre5 = Genre.create(name: "Genre5")
    @band1_genres = Array.new
    @band2_genres = Array.new
    @band3_genres = Array.new
    @band4_genres = Array.new
    @band5_genres = Array.new
    @band1_genres << @genre1.id
    @band1_genres << @genre2.id
    @band1_genres << @genre3.id    
    @band2_genres << @genre2.id
    @band2_genres << @genre3.id
    @band2_genres << @genre4.id
    @band3_genres << @genre3.id
    @band3_genres << @genre4.id
    @band3_genres << @genre5.id    
    @band4_genres << @genre4.id
    @band4_genres << @genre5.id
    @band4_genres << @genre1.id
    @band5_genres << @genre5.id
    @band5_genres << @genre1.id
    @band5_genres << @genre2.id
    @band1 = Band.create(name: "Band1", description: "Best Band!", genre_ids: @band1_genres)
    @band2 = Band.create(name: "Band2", description: "Best Band!", genre_ids: @band2_genres)
    @band3 = Band.create(name: "Band3", description: "Best Band!", genre_ids: @band3_genres)
    @band4 = Band.create(name: "Band4", description: "Best Band!", genre_ids: @band4_genres)
    @band5 = Band.create(name: "Band5", description: "Best Band!", genre_ids: @band5_genres)
    @manager1.bands << @band1
    @manager1.bands << @band2
    @manager2.bands << @band3
    @manager2.bands << @band4
    @manager2.bands << @band5
  end
  after(:all) do
    User.delete_all
    Band.delete_all
    Genre.delete_all
  end
  

  describe "landing page" do
    before { visit root_path }
      describe "C grade level" do
        describe "for all users" do
          it { should have_selector('title', text: "BandBlitz") }
          it { should have_link('Home',     href: root_path) }
          it { should have_link('Help',    href: help_path) }
          it { should have_link('Login',    href: login_path) }    
          it { should have_link('Signup',    href: signup_path) }
          it { should have_link('About', href: about_path) }
          it { should have_link('Contact', href: contact_path) }
        end
      
        describe "for non-signed in user" do
          it { should have_link('Band1')}
          it { should have_link('Band2')}
          it { should have_link('Band3')}
          it { should have_link('Band4')}
          it { should have_link('Band5')}
        end
      end
      
      describe "B grade level" do
        describe "for signed-in user" do
          before do
            sign_in @manager1
            visit root_path
          end
          it { should have_link('Profile', href: user_path(@manager1))}
          it { should have_link('Band1')}
          it { should have_link('Band2')}
        
          it { should_not have_link('Band3')}
          it { should_not have_link('Band4')}
          it { should_not have_link('Band5')}       
        end
      end
  end
end