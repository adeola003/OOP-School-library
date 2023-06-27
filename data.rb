require 'json'

module SavingData
  # ...

  def save_books
    File.open('books.json', 'w') do |file|
      file.write(JSON.generate(@books))
    end
  end

  def save_people
    File.open('people.json', 'w') do |file|
      file.write(JSON.generate(@people))
    end
  end

  def save_rentals
    File.open('rentals.json', 'w') do |file|
      file.write(JSON.generate(@rentals))
    end
  end
  # ...
end
