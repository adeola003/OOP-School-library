require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom)
    super()
    @classroom = classroom
    classroom.students << self
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
