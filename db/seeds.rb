# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "cleaning db************************************"

Mobile.destroy_all

puts "creating data base***********************"

Mobile.create([
  {
    brand: "Apple",
    model: "iPhone 15 Pro",
    release_date: "2023-09-22",
    display_size: 6.1,
    resolution: "2556x1179",
    processor: "A17 Pro",
    ram: 8,
    storage: 128,
    camera_main: 48,
    camera_front: 12,
    battery: 3274,
    os_version: "iOS 17",
    price: 999,
    image_url: "https://m.media-amazon.com/images/I/71657TiFeHL._AC_UL320_.jpg"
  },
  {
    brand: "Samsung",
    model: "Galaxy S23 Ultra",
    release_date: "2023-02-17",
    display_size: 6.8,
    resolution: "3088x1440",
    processor: "Snapdragon 8 Gen 2",
    ram: 12,
    storage: 256,
    camera_main: 200,
    camera_front: 12,
    battery: 5000,
    os_version: "Android 13",
    price: 1199,
    image_url: "https://m.media-amazon.com/images/I/31SrIF+Tt7L._SY300_SX300_.jpg"
  },
  {
    brand: "Realme",
    model: "Realme 7 pro",
    release_date: "2020-02-17",
    display_size: 6.8,
    resolution: "3088x1440",
    processor: "Snapdragon 8 Gen 2",
    ram: 12,
    storage: 256,
    camera_main: 228,
    camera_front: 12,
    battery: 5000,
    os_version: "Android 14",
    price: 1800,
    image_url: "https://fdn2.gsmarena.com/vv/pics/realme/realme-7-pro-2.jpg"
  },
  {
    brand: "OnePlus",
    model: "OnePlus Nord 2t",
    release_date: "2020-02-17",
    display_size: 6.8,
    resolution: "3088x1440",
    processor: "Snapdragon 8 Gen 2",
    ram: 8,
    storage: 132,
    camera_main: 228,
    camera_front: 12,
    battery: 5000,
    os_version: "Android 14",
    price: 1800,
    image_url: "https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-nord-2t-5g-2.jpg"
  }
  # Add more sample data...
])