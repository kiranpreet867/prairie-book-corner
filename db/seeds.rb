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

puts "Seed complete"
puts "Admin users: #{AdminUser.count}"
puts "Site pages: #{SitePage.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
