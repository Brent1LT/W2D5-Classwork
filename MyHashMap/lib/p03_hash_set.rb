require_relative "p02_hashing"
class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count + 1 > num_buckets
    index = self[key]
    if !@store[index].include?(key)
      @store[index] << key 
      @count += 1
    end
  end

  def include?(key)
    index = self[key]
    @store[index].include?(key) 
  end

  def remove(key)
    index = self[key]
    if @store[index].include?(key)
      @store[index].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num.hash % num_buckets
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
