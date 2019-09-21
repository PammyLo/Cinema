require_relative('./customer')
require_relative('./film')

class Ticket

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = details['customer_id'].to_i
    @screening_id = ['screening_id'].to_i
  end



end
