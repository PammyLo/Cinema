require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

require 'pry'

Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Jo Blog', 'funds' => '50'})
customer2 = Customer.new({'name' => 'Blair Jones', 'funds' => '80'})
customer3 = Customer.new({'name' => 'Karen Smith', 'funds' => '60'})
customer4 = Customer.new({'name' => 'George Fallows', 'funds' => '48'})

customer1.save()
customer2.save()
customer3.save()
customer4.save()

customer4.delete

customer1.funds = 75
customer1.update

customer2.find_by_id

film1 = Film.new({'title' => 'Star_Wars', 'price' => 10})
film2 = Film.new({'title' => 'Frozen', 'price' => 8})
film3 = Film.new({'title' => 'Moonlight', 'price' => 10})
film4 = Film.new({'title' => 'Mama Mia!', 'price' => 8})

film1.save
film2.save
film3.save
film4.delete

film1.price = 12
film1.update

film2.find_by_id
# p film1.all_screenings_by_film_id

screening1 = Screening.new({'start_time' => '2019 Sept 26, 9:00 PM', 'film_id' => film1.id, 'total_tickets' => 30})
screening2 = Screening.new({'start_time' => '2019 Sept 28, 3:00 PM', 'film_id' => film2.id, 'total_tickets' => 20})
screening3 = Screening.new({'start_time' => '2019 Sept 26, 11:00 PM', 'film_id' => film3.id, 'total_tickets' => 20})
screening4 = Screening.new({'start_time' => '2019 Sept 28, 9:00 PM', 'film_id' => film1.id, 'total_tickets' => 30})
screening5 = Screening.new({'start_time' => '2019 Sept 28, 2:00 PM', 'film_id' => film2.id, 'total_tickets' => 20})

screening1.save
screening2.save
screening3.save
screening4.save
screening5.save

screening5.delete

screening1.total_tickets = 40
screening1.update

screening2.find_tickets_available_by_id

ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening1.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening1.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening2.id})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening3.id})
ticket6 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening2.id})

ticket1.save #reserve
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save

ticket1.sell
ticket2.sell
ticket3.sell
ticket4.sell
ticket5.sell
ticket6.sell




# binding.pry
