# frozen_string_literal: true
 
require './linked_list'
require './node'

class HashMap
  attr_accessor :load_factor, :capacity, :map

  def initialize
        @load_factor = 0.75
        @capacity = 16
        @map = []
  end 

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    index = get_index(key)
    if @map[index].nil?
      @map[index] = start_list(key, value)
    elsif (l_i = @map[index].find_k(key)).nil?
      @map[index].append(key, value)
    else
      node = @map[index].at(l_i)
      node.value = value
    end
  end

  private

  def start_list(key, value)
    list = LinkedList.new
    list.append(key, value)
    list
  end

  def get_index(key)
    hash(key) % @capacity
  end
end