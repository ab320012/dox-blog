unless Rails.env.production?
  Article.destroy_all
  Page.destroy_all
  Author.destroy_all
end

Author.where(name: "John Doe", email: "jdoe@doximity.com", active: true).first_or_create


Article.where(title: Faker::Lorem.sentence(rand(3)+2)).first_or_create(
  body: Faker::Lorem.paragraph(rand(30)+30),
  published: true,
  author: Author.first,
  featured: false,
  subtitle: nil,
  hero_image_name: rand(2) == 1 ? 'beach.jpg' : 'airplane.jpg'
)


about_us = "In an industry where interoperability plagues the progress of health IT, our engineers have already
figured out how to get iPhones to talk to fax machines. And we’re just getting started."

Page.where(
  title: "About Doximity",
  body: about_us,
  published: true,
  featured: true,
  author: Author.first,
  subtitle: "Page Subtitle",
  hero_image_name: 'airplane.jpg'
).first_or_create

HeroImage.where(name: "airplane.jpg").first_or_create
HeroImage.where(name: "beach.jpg").first_or_create

Articles::ImportFromCSV.new.call
