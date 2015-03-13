require 'spec_helper'

describe "Band pages" do

  subject { page }

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
  
  
  describe "index" do

    before(:all) { 50.times { FactoryGirl.create(:band) } }
    after(:all)  { Band.delete_all }
    
    describe "C grade level" do
      describe "for a non-logged in user" do
        before {visit bands_path}
        it {should have_selector('title', text: 'The Bands of BandBlitz')}
      
        describe "pagination" do
          it { should have_selector('div.pagination') }

          it "should list each band" do
            Band.paginate(page: 1).each do |band|
              page.should have_selector('td>a', text: band.name)
            end
          end      
        end
      end
    end
    
    describe "B grade level" do
      describe "for managers (logged in users)" do      
        describe "should see list of their own bands" do
          before do
            sign_in @manager1
            visit bands_path
          end
          # it {should have_link(@band1.name)}
          it {should have_link(@band2.name)}
          it {should_not have_link(@band3.name)}
          it {should_not have_link(@band4.name)}
          it {should_not have_link(@band5.name)}
        end

        describe "should see links to edit their own bands" do
          before do
            sign_in @manager1
            visit bands_path
          end
          it { should have_link('edit', href: edit_band_path(@band1))}
          it { should have_link('edit', href: edit_band_path(@band2))}
          it { should_not have_link('edit', href: edit_band_path(@band3))}
          it { should_not have_link('edit', href: edit_band_path(@band4))}
          it { should_not have_link('edit', href: edit_band_path(@band5))}
        end
      
        describe "should be able to edit their own bands" do
          before do
            sign_in @manager1
            visit edit_band_path(@band1)
          end
        
          it { should have_selector('title', text: "Update Band") }
          it { should have_selector('h1', text: "Editing Band") }
        
          describe "with valid information" do
            let(:new_name) { "New Name" }
            let(:new_description) { "New Description" }
            before do
              visit edit_band_path(@band1)
              fill_in "Name",             with: new_name
              fill_in "Description",      with: new_description
              click_button "Update"
            end

            it { should have_selector('h1', text: new_name) }
            it { should have_selector('div.alert.alert-success') }
            specify { @band1.reload.name.should  == new_name }
            specify { @band1.reload.description.should == new_description }
          end
      
          describe "should not be able to edit other people's bands" do
            before {visit edit_band_path(@band5)}
        
            it { should have_selector('title', text: "The Bands of BandBlitz") }
          end
        end
      end
      
        describe "should see delete links for their own bands" do
          before do
            sign_in @manager2
            visit bands_path
          end
          it { should have_link('delete', href: band_path(@band3)) }
          it { should have_link('delete', href: band_path(@band4))}
          it { should have_link('delete', href: band_path(@band5))}
          it { should_not have_link('delete', href: band_path(@band1))}
          it { should_not have_link('delete', href: band_path(@band2))}
        
          it "should be able to delete their own bands" do
            expect { click_link('delete') }.to change(Band, :count).by(-1)
          end
        end
      end
    end
    
    describe "A grade level" do
      describe "for admins" do
        before do
          User.delete_all
          Band.delete_all
          Genre.delete_all
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
              
        describe "should see list of all bands" do
          before do
            @manager1.toggle!(:admin)
            sign_in @manager1
            visit bands_path
          end
          it {should have_link(@band1.name)}
          it {should have_link(@band2.name)}
          it {should have_link(@band3.name)}
          it {should have_link(@band4.name)}
          it {should have_link(@band5.name)}
        end
      
        describe "should be able to edit all bands" do
          before do
            @manager1.toggle!(:admin)
            sign_in @manager1
            visit bands_path
          end
            describe "should see edit links for all bands" do
               it { should have_link('edit', href: edit_band_path(@band1))}
               it { should have_link('edit', href: edit_band_path(@band2))}
               it { should have_link('edit', href: edit_band_path(@band3))}
               it { should have_link('edit', href: edit_band_path(@band4))}
               it { should have_link('edit', href: edit_band_path(@band5))} 
            end 
          
            describe "should be able to edit any band" do
              before {visit edit_band_path(@band5)}
              it { should have_selector('title', text: "Update Band") }
              it { should have_selector('h1', text: "Editing Band") } 
 
              describe "with valid information" do
                let(:new_name) { "New Name" }
                let(:new_description) { "New Description" }
                before do
                  visit edit_band_path(@band5)
                  fill_in "Name",             with: new_name
                  fill_in "Description",      with: new_description
                  click_button "Update"
                end
        
                it { should have_selector('h1', text: new_name) }
                it { should have_selector('div.alert.alert-success') }
                specify { @band5.reload.name.should  == new_name }
                specify { @band5.reload.description.should == new_description }
              end
            
            end
            describe "should see delete links for all bands" do
              before {visit bands_path}

              it { should have_link('delete', href: band_path(@band3)) }
              it { should have_link('delete', href: band_path(@band4))}
              it { should have_link('delete', href: band_path(@band5))}
              it { should have_link('delete', href: band_path(@band1))}
              it { should have_link('delete', href: band_path(@band2))}
      
              it "should be able to delete any band" do
                expect { click_link('delete') }.to change(Band, :count).by(-1)
              end
            end    
        end
      end
    end
end




