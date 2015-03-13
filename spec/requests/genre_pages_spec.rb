require 'spec_helper'

describe "Genre pages" do

  subject { page }  
  before(:all) do
    User.delete_all
    Band.delete_all
    Genre.delete_all
  end
  describe "index" do
    
    describe "C grade level" do
      describe "for a non-logged in user" do
        before {visit genres_path}
        it {should have_selector('title', text: 'Login')}
      end
    end
    
    describe "B grade level" do
      describe "for managers (logged in users)" do      
        describe "should see list of their own bands" do
          before do
            @manager1 = User.create(name: "Manager1", email: "manager1@bandblitz.com", password: "tartans", password_confirmation: "tartans")
            sign_in @manager1
            visit genres_path
          end
          it {should have_selector('title', text: 'The Bands of BandBlitz')}
        end
      end
    end
    
    describe "A grade level" do
      describe "for admins" do
        before do
          @manager2 = User.create(name: "Manager2", email: "manager2@bandblitz.com", password: "tartans", password_confirmation: "tartans")
          @manager2.toggle!(:admin)
          @genre1 = Genre.create!(name: "Genre1")
          @genre2 = Genre.create!(name: "Genre2")
          @genre3 = Genre.create!(name: "Genre3")
          @genre4 = Genre.create!(name: "Genre4")
          @genre5 = Genre.create!(name: "Genre5")
        end
        describe "should see list of all genres" do
          before do
            sign_in @manager2
            visit genres_path
          end
          it {should have_link(@genre1.name)}
          it {should have_link(@genre2.name)}
          it {should have_link(@genre3.name)}
          it {should have_link(@genre4.name)}
          it {should have_link(@genre5.name)}
        end

        describe "should be able to edit all genres" do
          before do
            sign_in @manager2
            visit genres_path
          end
            describe "should see edit links for all genres" do
               it { should have_link('edit', href: edit_genre_path(@genre1))}
               it { should have_link('edit', href: edit_genre_path(@genre2))}
               it { should have_link('edit', href: edit_genre_path(@genre3))}
               it { should have_link('edit', href: edit_genre_path(@genre4))}
               it { should have_link('edit', href: edit_genre_path(@genre5))} 
            end
            describe "should be able to edit any genre" do
              before {visit edit_genre_path(@genre5)}
              it { should have_selector('title', text: "Update Genre") }
              it { should have_selector('h1', text: "Editing Genre") } 
 
              describe "with valid information" do
                let(:new_name) { "New Name" }
                before do
                  visit edit_genre_path(@genre5)
                  fill_in "Name",             with: new_name
                  click_button "Update"
                end        
                it { should have_selector('div.alert.alert-success') }
                specify { @genre5.reload.name.should  == new_name }
              end            
            end
        end
      
        describe "should see delete links for all genres" do
          before do
            sign_in @manager2
            visit genres_path
          end
            
          it { should have_link('delete', href: genre_path(@genre3)) }
          it { should have_link('delete', href: genre_path(@genre4)) }
          it { should have_link('delete', href: genre_path(@genre5)) }
          it { should have_link('delete', href: genre_path(@genre1)) }
          it { should have_link('delete', href: genre_path(@genre2)) }
                  
          it "should be able to delete any genre" do
            expect { click_link('delete') }.to change(Genre, :count).by(-1)
          end
        end
      
      end
    end
  end
end
