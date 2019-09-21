require_relative("../db/sql_runner")
require_relative('./ticket')
require_relative('./film')


class Screening

  attr_reader :id
  attr_accessor :start_time, :film_id, :total_tickets

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @start_time = details['start_time']
    @film_id = details['film_id'].to_i
    @total_tickets = details['total_tickets'].to_i
  end

  def save
    sql = "INSERT INTO screenings(start_time, film_id, total_tickets)
          VALUES ($1, $2, $3) RETURNING id"
    values = [ @start_time, @film_id, @total_tickets ]
    screening = SqlRunner.run( sql, values ).first
    @id = screening['id'].to_i
  end

  def Screening.delete_all
    sql = 'DELETE FROM screenings'
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM screenings
          WHERE id = $1"
    values = [ @id ]
    SqlRunner.run( sql, values )
  end

  def update
    sql = 'UPDATE screenings
          SET start_time = $1, film_id = $2, total_tickets = $3
          WHERE id = $4'
    values = [ @start_time, @film_id, @total_tickets, @id ]
    SqlRunner.run( sql, values )
  end

  def find_tickets_available_by_id
    sql = 'SELECT total_tickets FROM screenings
          WHERE id = $1'
    values = [ @id ]
    tickets_available = SqlRunner.run( sql, values ).first
    return tickets_available    
  end

end
