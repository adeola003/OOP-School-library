require 'json'
# require_relative 'Teacher'
# require_relative 'Student'

module SavingData
  # ...

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
    File.write('jsons/people.json', JSON.pretty_generate(saved_people))
  end

  def save_books(books)
    saved_books = []
    books.each do |book|
      saved_books << { 'title' => book.title, 'author' => book.author }
    end
    File.write('jsons/books.json', JSON.pretty_generate(saved_books))
  end

  def save_rentals(rentals)
    saved_rentals = []
    rentals.each do |rental|
      saved_rentals << { 'person_name' => rental.person.name, 'books' => rental.book.title, 'date' => rental.date }
    end
    File.write('jsons/rentals.json', JSON.pretty_generate(saved_rentals))
  end

  # ...
  def save_data(people, books, rentals)
    save_people(people)
    save_books(books)
    save_rentals(rentals)
  end
end
