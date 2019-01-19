require 'byebug'
class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
   @store[num-1] = true if is_valid?(num)
  end

  def remove(num)
    is_valid?(num)
    @store[num-1] = false 
  end

  def include?(num)
    @store[num-1]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num < 0 || num > @store.length
    return true if @store[num-1] == false  
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # byebug
    index = self[num]
    @store[index] << num if !@store[index].include?(num)
  end

  def remove(num)
    index = self[num]
    @store[index].delete(num) if @store[index].include?(num)
  end

  def include?(num)
    index = self[num]
    @store[index].include?(num)
  end

  private

  def [](num)
  # optional but useful; return the bucket corresponding to `num`
    num % @store.length
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count + 1 > num_buckets
    index = self[num]
    if !@store[index].include?(num)
      @store[index] << num 
      @count += 1
    end
  end

  def remove(num)
    index = self[num]
    if @store[index].include?(num)
      @store[index].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    index = self[num]
    @store[index].include?(num) 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @store.length
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {[]}
    @store.flatten.each do |el|
      index = el % new_store.length
      new_store[index] << el 
    end 
    @store = new_store
  end
end
