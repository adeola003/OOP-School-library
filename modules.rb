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

module LibraryUtils
  def find_person_by_name(name)
    @people.find { |person| person.name == name }
  end

  def find_person_by_id(id)
    @people.find { |person| person.id == id }
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

  def list_rentals_for_person
    print 'Enter person name: '
    list_all_people
    print 'Enter person id: '
    person_id = gets.chomp.to_i
    person = find_person_by_id(person_id)
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
end
