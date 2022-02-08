require 'watir'
require 'nokogiri'

puts "What do you want to search?"
search = gets
search.gsub!(" ", "+")

b = Watir::Browser.new :firefox
b.goto 'https://www.amazon.com/s?k=' + search
p = Nokogiri::HTML.parse(b.html)

products_array = []

p.css('html body div.a-section > div.sg-row').map do |a|
  product_name = a.css('a.a-link-normal span.a-size-medium').text
  product_price = a.css('span.a-text-price span.a-offscreen').text
  unless product_name.empty? || product_price.empty?
    product = {:name => product_name,:price => product_price}
    products_array.push(product)
  end
end

puts products_array