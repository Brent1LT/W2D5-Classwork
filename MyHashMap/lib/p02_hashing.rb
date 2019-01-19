class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
  return 72 if self.length == 0
   value = 0
   self[0..-2].each do |int|
    value += int
   end
   a = self[-1].hash if self[-1].is_a?(Array)
   return value - self[-1] unless self[-1].is_a?(Array)
   value - a if self[-1].is_a?(Array)
  end
end

class String
  def hash
    hash_alpha = ("a".."z").to_a
    return hash_alpha.index(self) + 1 if self.length == 1
    value = 0 
    self[0..-2].each_char do |el|
      value += hash_alpha.index(el.downcase)
    end
    value / hash_alpha.index(self[-1])
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    value = 0
    self.values.each do |letter|
      value += letter.hash
    end
    value
  end
end
