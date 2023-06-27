require_relative 'person'

class Student < Person
  attr_reader :classroom, :parent_permission

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(age, name)
    @classroom = classroom
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
