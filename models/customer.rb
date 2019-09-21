require_relative("../db/sql_runner")

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


end
