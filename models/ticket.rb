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

end
