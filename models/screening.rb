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

  def Screening.most_popular_screening_by_film(film)
    sql = 'SELECT title, start_time AS Most_popular_screening, COUNT(tickets.id) AS tickets_sold
          FROM films, screenings, tickets
          WHERE films.id = screenings.film_id
          AND screenings.id = tickets.screening_id
          AND films.id = $1
          GROUP BY title, start_time
          ORDER BY count(tickets.id) DESC
          LIMIT 1'
    values = [ film.id ]
    most_popular_screening = SqlRunner.run( sql, values )
    return most_popular_screening.map { |scr| puts (scr)}
  end

  def Screening.screenings_table
    sql = 'SELECT title, start_time AS screening
          FROM films, screenings
          WHERE films.id = screenings.film_id'
    screenings_table = SqlRunner.run( sql )
    return screenings_table.map { |screenings| puts(screenings)}
  end

end
