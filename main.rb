require_relative 'app'
require_relative 'modules'
require_relative 'data'

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

def run(app)
  puts 'Welcome to the Console Library App!'
  loop do
    display_options
    choice = gets.chomp.to_i
    handle_choice(choice, app)
    break if choice == 7
  end
  puts 'Thank you for using the Console Library App. Goodbye!'
end

def handle_choice(choice, app)
  case choice
  when 1 then app.list_all_books
  when 2 then app.list_all_people
  when 3 then app.create_person
  when 4 then app.create_book
  when 5 then app.create_rental
  when 6 then app.list_rentals_for_person
  else
    app.save_data(app.people, app.books, app.rentals)
    exit
  end
end

def main
  # app = App.new(data['books'], data['people'], data['rentals'])
  app = App.new
  app.load_file_data
  run(app)
end

main
