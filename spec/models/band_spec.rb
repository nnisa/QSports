require 'spec_helper'

describe Band do

  before do
   @band = Band.new(name: "My Band", description: "The best band!")
  end

  subject { @band }
  describe "D grade level" do
    it { should respond_to(:name) }
    it { should respond_to(:description) }

    it { should be_valid }
  end
  
  describe "C grade level" do
    describe "when name is not present" do
      before { @band.name = " " }
      it { should_not be_valid }
    end

    describe "when description is not present" do
      before { @band.description = " " }
      it { should_not be_valid }
    end
  end
  
  describe "B grade level" do
    describe "when name is too long" do
      before { @band.name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when band name is already taken" do
      before do
        band_with_same_name = @band.dup
        band_with_same_name.name = @band.name
        band_with_same_name.save
      end

      it { should_not be_valid }
    end
  end

  describe "A grade level" do
    describe "user associations" do    
      it "should have the right number of users" do
        @band = Band.create(name: "My Band", description: "The Best Band!")
    
        5.times do |n|
            @band.users << User.create(name: "Name_#{n}", email: "test_#{n}@cmu.edu", password: "tartans", password_confirmation: "tartans")
        end
        @band.users.count == 5
      end
    end 

    describe "genre associations" do    
      it "should have the right number of genres" do
        @band = Band.create(name: "My Band", description: "The Best Band!")
    
        5.times do |n|
            @band.genres << Genre.create(name: "Genre_#{n}")
        end
        @band.genres.count == 5
      end
    end

    describe "adding photo" do
      before(:each){ @attr = { :name => "My Band", :description => "some text is here", :photo => File.open(File.join(Rails.root, '/spec/support/files/violin.JPG')) }}

      describe "uploaded" do
        it "should not cause an error" do
          expect do
            Band.create( @attr )
          end.to change( Band, :count ).by( 1 )
        end
      end
    end

    describe "adding song" do
      before(:each){ @attr = { :name => "My Band", :description => "some text is here", :song => File.open(File.join(Rails.root, '/spec/support/files/Spring.mp3')) }}

      describe "uploaded" do
        it "should not cause an error" do
          expect do
            Band.create( @attr )
          end.to change( Band, :count ).by( 1 )
        end
      end
    end
    
  end
end
