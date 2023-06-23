require_relative 'classroom'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    puts 'Welcome to the Console Library App!'
    loop do
      display_options
      choice = gets.chomp.to_i
      handle_choice(choice)
      break if choice == 7
    end
    puts 'Thank you for using the Console Library App. Goodbye!'
  end

  private

  def display_options
    puts "\nPlease choose an option:"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
  end

  def handle_choice(choice)
    case choice
    when 1 then list_all_books
    when 2 then list_all_people
    when 3 then create_person
    when 4 then create_book
    when 5 then create_rental
    when 6 then list_rentals_for_person
    else
      puts 'Invalid option. Please try again.'
    end
  end

  def list_all_books
    if @books.empty?
      puts 'No books available.'
    else
      puts 'Listing all books:'
      @books.each { |book| puts "#{book.title} by #{book.author}" }
    end
  end

  def list_all_people
    if @people.empty?
      puts 'No people available.'
    else
      puts 'Listing all people:'
      @people.each { |person| puts "#{person.name} (ID: #{person.id})" }
    end
  end

  def create_person
    puts 'Enter person details:'
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Enter 1 for a teacher of 2 for a student: '
    is_teacher = gets.chomp.downcase == '1'

    if is_teacher
      create_teacher(name, age)
    else
      create_student(name, age)
    end
  end

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

  def create_book
    puts 'Enter book details:'
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully.'
  end

  def create_rental
    puts 'Enter rental details:'
    print 'Person name: '
    person_name = gets.chomp
    person = find_person_by_name(person_name)
    if person.nil?
      puts 'Person not found.'
      return
    end

    print 'Book title: '
    book_title = gets.chomp
    book = find_book_by_title(book_title)
    if book.nil?
      puts 'Book not found.'
      return
    end

    print 'Rental date (YYYY-MM-DD): '
    date = gets.chomp

    rental = Rental.new(date, book, person)
    @rentals << rental

    puts 'Rental created successfully.'
  end
  def list_rentals_for_person
    print 'Enter person name: '
    person_name = gets.chomp
    person = find_person_by_name(person_name)
    if person.nil?
      puts 'Person not found.'
      return
    end

    rentals = @rentals.select { |rental| rental.person == person }

    if rentals.empty?
      puts 'No rentals found for the person.'
    else
      puts "Listing rentals for #{person.name}:"
      rentals.each do |rental|
        puts "Book: #{rental.book.title}, Rental Date: #{rental.date}"
      end
    end
  end

  def find_person_by_id(person_id)
    @people.find { |person| person.id == person_id }
  end

  def find_book_by_title(book_title)
    @books.find { |book| book.title == book_title }
  end

  def find_classroom_by_label(classroom_label)
    @people.each do |person|
      return person.classroom if person.is_a?(Student) && person.classroom.label == classroom_label
    end
    nil
  end

  def find_person_by_name(name)
    @people.find { |person| person.name == name }
  end

end
