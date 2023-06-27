require 'json'
require_relative 'teacher'
require_relative 'student'
require_relative 'rentals'

module SavingData
  def save_people(people)
    saved_people = []
    people.each do |person|
      if person.instance_of?(::Teacher)
        saved_people << { 'type' => 'Teacher', 'id' => person.id, 'age' => person.age, 'name' => person.name,
                          'specialization' => person.specialization }
      elsif person.instance_of?(::Student)
        saved_people << { 'type' => 'Student', 'id' => person.id, 'age' => person.age, 'name' => person.name,
                          'parent_permission' => person.parent_permission }
      end
    end

    if File.exist?('jsons/people.json')
      File.write('jsons/people.json', JSON.pretty_generate(saved_people))
    else
      json_file = saved_people.to_json
      File.write('jsons/people.json', json_file)
    end
  end

  def save_books(books)
    saved_books = []
    books.each do |book|
      saved_books << { 'title' => book.title, 'author' => book.author }
    end

    if File.exist?('jsons/books.json')
      File.write('jsons/books.json', JSON.pretty_generate(saved_books))
    else
      json_file = saved_books.to_json
      File.write('jsons/books.json', json_file)
    end
  end

  def save_rentals(rentals)
    saved_rentals = []
    rentals.each do |rental|
      saved_rentals << { 'person_name' => rental.person.name, 'book_title' => rental.book.title, 'date' => rental.date }
    end

    if File.exist?('jsons/rentals.json')
      File.write('jsons/rentals.json', JSON.pretty_generate(saved_rentals))
    else
      json_file = saved_rentals.to_json
      File.write('jsons/rentals.json', json_file)
    end
  end

  def save_data(people, books, rentals)
    save_people(people)
    save_books(books)
    save_rentals(rentals)
  end
end
