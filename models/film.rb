class Film

  attr_accessor :title, :price

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @title = 'title'
    @price = 'price'.to_i
  end


end
