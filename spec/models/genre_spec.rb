require 'spec_helper'

describe Genre do

  before do
   @genre = Genre.new(name: "Pop")
  end

  subject { @genre }
  describe "D grade level" do
    it { should respond_to(:name) }

    it { should be_valid }
  end
  
  describe "C grade level" do
    describe "when name is not present" do
      before { @genre.name = " " }
      it { should_not be_valid }
    end
  end
  
  describe "B grade level" do
    describe "when name is too long" do
      before { @genre.name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when genre name is already used" do
      before do
        genre_with_same_name = @genre.dup
        genre_with_same_name.name = @genre.name
        genre_with_same_name.save
      end

      it { should_not be_valid }
    end
  end
  
  describe "A grade level" do

    describe "band associations" do    
      it "should have the right number of bands" do
        @new_genre = Genre.create(name: "Pop")
      
        5.times do |n|
            @new_genre.bands << Band.create(name: "Band_#{n}")
        end
        @new_genre.bands.count == 5
      end
    end 
  end
end
