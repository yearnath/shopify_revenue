# Created by Nathaniel Yearwood
# 01/16/2017

require 'open-uri'
require 'json'

revenue = 0 #total revenue (in dollars)
order_count = 0
page = 1 #inserted into the url to select page


loop do 
	#retrieves data from URL, parses as JSON, then gets key of "orders"
	orders = JSON.parse(open('https://shopicruit.myshopify.com/admin/orders.json?page=' +
		page.to_s + '&access_token=c32313df0d0ef512ca64d5b336a0d7c6') {
		|f| f.read})["orders"]

	break if orders.length < 1 #if page has no orders, stops running


	# prints total revenue up to each order, then adds subtotal
	# also counts the number of orders
	orders.each {|x| puts "revenue: #{revenue}, subtotal: #{x["subtotal_price"]}"
		revenue += x["subtotal_price"].to_f
		order_count += 1}

	page += 1 # goes to the next page in following iteration 
end

#turns up way too many decimal points for some reason
#193.66 + 492.78 = 686.4399999999999?????????????
revenue = revenue.round(2)

puts "\nTotal revenue from #{order_count} orders is $#{revenue}\n\n"