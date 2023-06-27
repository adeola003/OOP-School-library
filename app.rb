require 'json'
require_relative 'classroom'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rentals'
require_relative 'modules'
require_relative 'create_teacher_student'
require_relative 'data'

class App
  include LibraryUtils
  include SavingData
  attr_reader :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def load_book_data(books_json)
    books_json.each do |book|
      @books << Book.new(book['title'], book['author'])
    end
  end

  def load_people_data(people_json)
    people_json.each do |person|
      @people << if person['type'] == 'Teacher'
                   Teacher.new(person['age'], person['specialization'], person['name'])
                 elsif person['type'] == 'Student'
                   parent_info = person['parent_permission'] || true
                   Student.new(person['age'], 'first', person['name'], parent_permission: parent_info)
                 end
    end
  end

  def load_rental_data(rentals_json)
    rentals_json.each do |rent|
      rentee = @people.select { |person| person.name == rent['person_name'] }
      rented_book = @books.select { |book| book.title == rent['book_title'] }
      @rentals << Rental.new(rent['date'], rented_book[0], rentee[0])
    end
  end

  def load_file_data
    books_json = JSON.parse(fetch_file('books'))
    people_json = JSON.parse(fetch_file('people'))
    rentals_json = JSON.parse(fetch_file('rentals'))
    load_book_data(books_json)
    load_people_data(people_json)
    load_rental_data(rentals_json)
  end

  def fetch_file(filename)
    if File.exist?("jsons/#{filename}.json")
      File.read("jsons/#{filename}.json")
    else
      json_file = [].to_json
      File.write("jsons/#{filename}.json", json_file)
      json_file
    end
  end

  def list_all_books
    if @books.empty?
      puts 'No books available.'
    else
      puts 'Listing all books:'
      @books.each_with_index do |book, index|
        puts "#{index}. #{book.title} by #{book.author}"
      end
    end
  end

  def list_all_people
    if @people.empty?
      puts 'No people available.'
    else
      puts 'Listing all people:'
      @people.each_with_index do |person, index|
        puts "#{index}. #{person.name} - (ID: #{person.id})"
      end
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
