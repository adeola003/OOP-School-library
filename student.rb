require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'unknown')
    super(age, name)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
