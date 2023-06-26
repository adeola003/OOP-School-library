require_relative 'teacher'

def create_teacher(name, age)
  print 'Specialization: '
  specialization = gets.chomp
  person = Teacher.new(age, specialization, name)
  @people << person
  puts 'Teacher created successfully.'
end
