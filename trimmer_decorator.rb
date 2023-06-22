require_relative 'decorator'
class TrimmerDecorator < Decorator
  def correct_name
    original_name = @nameable.correct_name
    if original_name.length > 10
      original_name[0, 10].strip
    else
      original_name
    end
  end
end
