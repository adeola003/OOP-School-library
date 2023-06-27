require_relative 'app'
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

def main
  display_options
  app = App.new
  app.run
end

main
