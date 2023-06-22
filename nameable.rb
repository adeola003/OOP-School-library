class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented the correct_name method"
  end
end
