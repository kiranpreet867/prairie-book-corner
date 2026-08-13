# Create the default ActiveAdmin account without duplicating it
AdminUser.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

# Keep the editable public pages available
SitePage.find_or_create_by!(slug: "about") do |page|
  page.title = "About Prairie Book Corner"
  page.content =
    "Prairie Book Corner is a Winnipeg bookstore offering books, journals, planners, and reading accessories."
end

SitePage.find_or_create_by!(slug: "contact") do |page|
  page.title = "Contact Prairie Book Corner"
  page.content =
    "Contact us by email at info@prairiebookcorner.ca or visit our Winnipeg store."
end

category_details = {
  "Fiction" => "Novels, mysteries, fantasy, and literature.",
  "Non-Fiction" => "History, biographies, business, and self-improvement.",
  "Children's Books" => "Stories and learning books for young readers.",
  "Educational" => "Textbooks, study guides, and professional learning resources."
}

categories = category_details.map do |name, description|
  Category.find_or_create_by!(name: name) do |category|
    category.description = description
  end
end

# Remove previously Faker-generated products so repeated seeding does not
# continue adding another 100 products.
Product.where("name LIKE ?", "Prairie Book %").destroy_all

100.times do |number|
  Product.create!(
    name: "Prairie Book #{number + 1}: #{Faker::Book.title}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 8.99..89.99),
    stock_quantity: rand(5..50),
    on_sale: [ true, false, false ].sample,
    category: categories.sample
  )
end

# Canadian provinces and territories with tax rates

provinces = [
  { name: "Alberta", code: "AB", gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: "British Columbia", code: "BC", gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: "Manitoba", code: "MB", gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: "New Brunswick", code: "NB", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Newfoundland and Labrador", code: "NL", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Northwest Territories", code: "NT", gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: "Nova Scotia", code: "NS", gst: 0.0, pst: 0.0, hst: 14.0 },
  { name: "Nunavut", code: "NU", gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: "Ontario", code: "ON", gst: 0.0, pst: 0.0, hst: 13.0 },
  { name: "Prince Edward Island", code: "PE", gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: "Quebec", code: "QC", gst: 5.0, pst: 9.975, hst: 0.0 },
  { name: "Saskatchewan", code: "SK", gst: 5.0, pst: 6.0, hst: 0.0 },
  { name: "Yukon", code: "YT", gst: 5.0, pst: 0.0, hst: 0.0 }
]

provinces.each do |province|
  record = Province.find_or_initialize_by(code: province[:code])

  record.name = province[:name]
  record.gst = province[:gst]
  record.pst = province[:pst]
  record.hst = province[:hst]

  record.save!
end

puts "Seed complete"
puts "Admin users: #{AdminUser.count}"
puts "Site pages: #{SitePage.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Provinces: #{Province.count}"

puts "Seed complete"
puts "Admin users: #{AdminUser.count}"
puts "Site pages: #{SitePage.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
