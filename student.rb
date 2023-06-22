require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission, id: id)
    @classroom = nil
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students << self
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end

