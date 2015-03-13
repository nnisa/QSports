require 'spec_helper'

describe "Static Pages" do
  subject { page }
  describe "D grade level" do
    describe "About Page" do
      before { visit about_path }
      it {should have_selector('h1', :text => 'About')}
      it {should have_selector('title', :text => 'About')}
    end
  
    describe "Contact Page" do
      before { visit contact_path }
      it {should have_selector('h1', :text => 'Contact')}    
      it {should have_selector('title', :text => 'Contact')}
    end
  
    describe "Help Page" do
      before { visit help_path }
      it {should have_selector('h1', :text => 'Help')}
      it {should have_selector('title', :text => 'Help')}
    end
  end
end