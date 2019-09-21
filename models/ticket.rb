require_relative('./customer')
require_relative('./film')

class Ticket

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = 'customer_id'.to_i
    @film_id = 'film_id'.to_i
  end

end
