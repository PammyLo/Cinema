require_relative('./ticket')
require_relative('./film')

class Screening

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @start_time = 'start_time'.to_datetime
    @ticket_id = 'ticket_id'
    @film_id = 'film_id'
  end 


end
