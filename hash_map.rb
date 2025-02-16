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

  def get(key)
    index = get_index(key)
    return nil unless @map[index]
    return nil if (l_i = @map[index].find_k(key)).nil?
    node = @map[index].at(l_i)
    node.value
  end

  def has?(key)
    index = get_index(key)
    return false unless @map[index]
    return false unless @map[index].find_k(key)
    return true
  end

  def remove(key)
    value = nil
    index = get_index(key)
    l_i = @map[index].find_k(key)
    if  l_i
      value = get(key)
      @map[index].remove_at(l_i)
    end
    value
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