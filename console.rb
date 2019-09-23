require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

require 'pry'

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Jo Blog', 'funds' => '50'})
customer2 = Customer.new({'name' => 'Blair Jones', 'funds' => '50'})
customer3 = Customer.new({'name' => 'Karen Smith', 'funds' => '50'})
customer4 = Customer.new({'name' => 'George Fallows', 'funds' => '50'})

customer1.save()
customer2.save()
customer3.save()
customer4.save()

# customer4.delete

customer1.funds = 5
customer1.update

customer2.find_by_id
customer1.find_funds


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
screening3 = Screening.new({'start_time' => '2019 Sept 26, 11:00 PM', 'film_id' => film3.id, 'total_tickets' => 0})
screening4 = Screening.new({'start_time' => '2019 Sept 28, 9:00 PM', 'film_id' => film1.id, 'total_tickets' => 30})
screening5 = Screening.new({'start_time' => '2019 Sept 28, 2:00 PM', 'film_id' => film2.id, 'total_tickets' => 20})
screening6 = Screening.new({'start_time' => '2019 Sept 28, 4:00 PM', 'film_id' => film2.id, 'total_tickets' => 20})
screening6 = Screening.new({'start_time' => '2019-09-28 16:00:00', 'film_id' => film2.id, 'total_tickets' => 20})

screening1.save
screening2.save
screening3.save
screening4.save
screening5.save
screening6.save

# screening5.delete

screening1.total_tickets = 40
screening1.update

screening2.find_tickets_available_by_id

ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening1.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening1.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening2.id})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening3.id})
ticket6 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening2.id})
ticket7 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening4.id})
ticket8 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening6.id})
ticket9 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => screening6.id})
ticket10 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => screening6.id})
ticket11 = Ticket.new({'customer_id' => customer4.id, 'screening_id' => screening6.id})

# ticket1.save
# ticket2.save
# ticket3.save
# ticket4.save
# ticket5.save
# ticket6.save
#
# ticket1.find_price
# ticket1.find_customer_funds
# ticket1.find_customer_name
# ticket1.tickets_available?

ticket1.sell
ticket2.sell
ticket3.sell
ticket4.sell
ticket5.sell
ticket6.sell
ticket7.sell
ticket8.sell
ticket9.sell
ticket10.sell
ticket11.sell

# customer2.number_by_customer
# customer3.films_by_customer

# Screening.most_popular_screening_by_film(film2)
most_popular_screening = Screening.most_popular_screening_by_film(film2)
most_popular_screening.each { |scr| puts (scr)}

films_and_screenings = Screening.films_and_screenings
films_and_screenings.each { |screening| puts screening}



Ticket.number_by_screening(screening1)
Ticket.number_by_film(film2)

# binding.pry
