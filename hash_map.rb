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
    index = hash(key) % @capacity
    if !@map[index]
      list = LinkedList.new
      list.append(key, value)
      @map[index] = list
      return
    end
    l_i = @map[index].find_k(key)
    if l_i
      node = @map[index].at(l_i)
      node.value = value
    else
      @map[index].append(key, value)
    end
  end
end