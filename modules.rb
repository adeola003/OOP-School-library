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
    @people.each do |person|
      puts "#{person.id}. #{person.name}"
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
end
