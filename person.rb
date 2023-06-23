require_relative 'nameable'
class Person < Nameable
  attr_accessor :name, :age
  attr_reader :rentals, :id

  def initialize(age, name, parent_permission: true, id: rand(1..100))
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(book, date)
    rental = Rental.new(date, book, self)
    @rentals << rental
    book.rentals << rental
    rental
  end

  private

  def of_age?
    @age >= 18
  end
end
