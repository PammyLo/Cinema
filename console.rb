require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

require 'pry'


Customer.delete_all

customer1 = Customer.new({'name' => 'Jo Blog', 'funds' => '50'})
customer2 = Customer.new({'name' => 'Blair Jones', 'funds' => '80'})
customer3 = Customer.new({'name' => 'Karen Smith', 'funds' => '60'})

customer1.save()
customer2.save()
customer3.save()

customer2.delete

customer1.funds = 75
customer1.update

p customer3.customer_by_id

binding.pry
