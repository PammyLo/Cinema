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

  def sell
    self.save
    customer_name = self.find_customer_name
    customer_funds = self.find_customer_funds
    customer_funds -= self.find_price
    if customer_funds < 0
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

end
