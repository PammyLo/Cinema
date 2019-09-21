require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

require 'pry'


Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Jo Blog', 'funds' => '50'})
customer2 = Customer.new({'name' => 'Blair Jones', 'funds' => '80'})
customer3 = Customer.new({'name' => 'Karen Smith', 'funds' => '60'})

customer1.save()
customer2.save()
customer3.save()

customer3.delete

customer1.funds = 75
customer1.update

customer2.find_by_id

film1 = Film.new({'title' => 'Moonlight', 'price' => 10})
film2 = Film.new({'title' => 'Star_Wars', 'price' => 10})
film3 = Film.new({'title' => 'Frozen', 'price' => 8})

film1.save
film2.save
film3.save

film3.delete

film1.price = 8
film1.update

film2.find_by_id


binding.pry
