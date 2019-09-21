class Film

  attr_accessor :title, :price

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @price = details['price'].to_i
  end

  def save
    sql = 'INSERT INTO films(title, price)
          VALUES ($1, $2) RETURNING id'
    values = [ @title, @price ]
    new_film = SqlRunner.run( sql, values ).first
    @id = new_film['id'].to_i
  end

  def Film.delete_all
    sql = 'DELETE FROM films'
    SqlRunner.run( sql )
  end

  def delete
    sql = 'DELETE FROM films
          WHERE id = $1'
    values = [ @id ]
    SqlRunner.run( sql, values )
  end

  def update
    sql = "UPDATE films
          SET title = $1, price = $2
          WHERE id = $3"
    values = [ @title, @price, @id ]
    SqlRunner.run( sql, values )
  end

  def find_by_id
    sql = "SELECT title FROM films
          WHERE id = $1"
    values = [ @id ]
    film = SqlRunner.run( sql, values ).first
    return film

  end


end
