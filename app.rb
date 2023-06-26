require_relative 'classroom'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'modules'
require_relative 'create_teacher_student'

class App
  include LibraryUtils
  def initialize
    @books = []
    @people = []
    @rentals = []
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
    list_all_people_and_select_person
    list_all_books_and_select_book
    enter_rental_date_and_create_rental
  end

  def list_all_people_and_select_person
    puts 'List of people:'
    list_all_people

    print 'Enter the number of the person: '
    person_number = gets.chomp.to_i
    person = @people[person_number]

    if person.nil?
      puts 'Person not found.'
      return
    end

    @selected_person = person
  end

  def list_all_books_and_select_book
    puts 'List of books:'
    list_all_books

    print 'Enter the number of the book: '
    book_number = gets.chomp.to_i
    book = @books[book_number]

    if book.nil?
      puts 'Book not found.'
      return
    end

    @selected_book = book
  end

  def enter_rental_date_and_create_rental
    print 'Rental date (YYYY-MM-DD): '
    date = gets.chomp

    rental = Rental.new(date, @selected_book, @selected_person)
    @rentals << rental

    puts 'Rental created successfully.'
  end
end
