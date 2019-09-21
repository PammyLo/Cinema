require_relative("../db/sql_runner")

class Customer

attr_accessor :name, :funds

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = 'name'
    @funds = 'funds'.to_i
  end

  def save
    sql = 'INSERT INTO customers ( name, funds )
          VALUES ($1, $2) RETURNING id'
    values = [ @name, @funds ]
    SqlRunner.run( sql, values )
  end


end
