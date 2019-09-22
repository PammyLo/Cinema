require_relative("../db/sql_runner")
require_relative('./customer')
require_relative('./film')
require_relative('./screening')

class Ticket

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = details['customer_id'].to_i
    @screening_id = details['screening_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets( customer_id, screening_id)
          VALUES ($1, $2) RETURNING id'
    values = [ @customer_id, @screening_id ]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  def delete
    sql = 'DELETE FROM tickets
          WHERE @id = $1'
    values = [ @id ]
    SqlRunner.run( sql, values )
  end

  def find_price
    sql = 'SELECT price FROM films, screenings
          WHERE films.id = screenings.film_id
          AND screenings.id = $1'
    values = [ @screening_id ]
    found_price = SqlRunner.run( sql, values ).first
    return found_price['price'].to_i
  end

  def find_customer_funds
    sql = 'SELECT funds FROM customers, tickets
          WHERE customers.id = tickets.customer_id
          AND customers.id = $1'
    values = [ @customer_id ]
    customer = SqlRunner.run( sql, values ).first
    return customer['funds'].to_i
  end

  def find_customer_name
    sql = 'SELECT name FROM customers, tickets
          WHERE customers.id = tickets.customer_id
          AND customers.id = $1'
    values = [ @customer_id ]
    customer = SqlRunner.run( sql, values ).first
    return customer['name']
  end

  def tickets_available?
    sql = 'SELECT total_tickets FROM screenings, tickets
          WHERE screenings.id = tickets.screening_id
          AND screening_id = $1'
    values = [ @screening_id ]
    tickets_available = SqlRunner.run( sql, values ).first
    return true if tickets_available['total_tickets'].to_i > 0
  end

#  the sell ticket function uses all 6 functions above to run
  def sell
    self.save
    customer_name = self.find_customer_name
    customer_funds = self.find_customer_funds
    customer_funds -= self.find_price
    if customer_funds < 0 || !self.tickets_available?
      self.delete
      return
    end
    sql = 'UPDATE customers
          SET name = $1, funds = $2
          WHERE id = $3'
    values = [ customer_name, customer_funds, @customer_id ]
    SqlRunner.run( sql, values )
  end

  def Ticket.delete_all
    sql = 'DELETE FROM tickets'
    SqlRunner.run( sql )
  end

  def Ticket.number_by_customer(customer)
    sql = "SELECT id FROM tickets
          WHERE customer_id = $1"
    values = [ customer.id ]
    customer_tickets = SqlRunner.run( sql, values )
    return customer_tickets.count
  end

  def Ticket.number_by_screening(screening)
    sql = 'SELECT id FROM tickets
          WHERE screening_id = $1'
    values = [ screening.id ]
    viewers = SqlRunner.run( sql, values )
    return viewers.count
  end

  def Ticket.number_by_film(film)
    sql = 'SELECT count(tickets.id) FROM tickets, screenings
          WHERE tickets.screening_id = screenings.id
          AND film_id = $1'
    values = [ film.id ]
    viewers = SqlRunner.run( sql, values ).first
    return viewers['count'].to_i
  end

  #   # ANOTHER VERSION WHERE THE COUNT IS EXECUTED BY SQL QUERY:
  #
  # def Ticket.number_by_screening(screening)
  #   sql = 'SELECT count(id) FROM tickets
  #         WHERE screening_id = $1'
  #   values = [ screening.id ]
  #   viewers = SqlRunner.run( sql, values ).first
  #   return viewers['count'].to_i
  # end



#find most popular screening for particular film
#find total tickets sold for screenings where films
  def method_name

  end

end
