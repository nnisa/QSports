namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Ali Naqi",
                 email: "alinaqi@cmu.edu",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)

    User.create!(name: "Example Manager",
                 email: "manager@example.com",
                 password: "foobar",
                 password_confirmation: "foobar")

    Band.create!(name: "One Direction", description: "Following the success of JLS and the Wanted, X-Factor contestants One Direction were the next group of heartthrobs to help revive the previously dying concept of the boy band.")
    

    Band.create!(name: "Linkin Park", description: "Although rooted in alternative metal, Linkin Park became one of the most successful acts of the early 2000s by welcoming elements of hip-hop, modern rock, and atmospheric electronica into their music.")
  
    Genre.create!(name: "Alternative Rock")

    Genre.create!(name: "Hard Rock")

    Genre.create!(name: "Hip Hop")

    Genre.create!(name: "Rock")

    Genre.create!(name: "Pop")

    Genre.create!(name: "Vocal")
  end
end