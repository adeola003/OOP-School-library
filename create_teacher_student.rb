require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'

def create_teacher(name, age)
  print 'Specialization: '
  specialization = gets.chomp
  person = Teacher.new(age, specialization, name)
  @people << person
  puts 'Teacher created successfully.'
end

def create_student(name, age)
  print 'Has parent permission? [Y/N] : '
  permission = gets.chomp
  if permission == 'Y'
    student = Student.new(age, 'first', name)
    classroom = Classroom.new('first')
    classroom.add_student(student)
    @people << student
    puts 'Person created successfully.'
  else
    puts 'No permission = No account creation'
  end
end
