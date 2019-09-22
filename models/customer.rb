require_relative("../db/sql_runner")
require_relative('./ticket')

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @funds = details['funds'].to_i
  end

  def save
    sql = 'INSERT INTO customers ( name, funds )
          VALUES ($1, $2) RETURNING id'
    values = [ @name, @funds ]
    customer = SqlRunner.run( sql, values )[0]
    @id = customer['id'].to_i
  end

  def Customer.delete_all
    sql = 'DELETE FROM customers'
    SqlRunner.run( sql )
  end

  def delete
    sql = 'DELETE FROM customers
          WHERE @id = $1'
    values = [ @id ]
    SqlRunner.run( sql, values )
  end

  def update
    sql = "UPDATE customers
          SET name = $1, funds = $2
          WHERE id = $3"
    values = [ @name, @funds, @id ]
    SqlRunner.run( sql, values)
  end

  def find_by_id
    sql = 'SELECT name FROM customers
          WHERE id = $1'
    values = [ @id ]
    customer = SqlRunner.run( sql, values ).first
    return customer
  end

  def find_funds
    sql = 'SELECT funds FROM customers
          WHERE id = $1'
    values = [ @id ]
    customer = SqlRunner.run( sql, values ).first
    return customer['funds'].to_i
  end

  def number_by_customer
    sql = "SELECT id FROM tickets
          WHERE customer_id = $1"
    values = [ @id ]
    customer_tickets = SqlRunner.run( sql, values )
    return customer_tickets.count
  end

  def films_by_customer
    sql = "SELECT title, start_time FROM films, screenings, tickets
          WHERE films.id = screenings.film_id
          AND screenings.id = tickets.screening_id
          AND customer_id = $1"
    values = [ @id ]
    customer_films = SqlRunner.run( sql, values )
    return customer_films.map { |films| puts(films) }
  end


end
