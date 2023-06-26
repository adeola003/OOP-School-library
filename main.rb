require_relative 'app'
require_relative 'homepage'

def main

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
  app = App.new
  app.run
end

main
