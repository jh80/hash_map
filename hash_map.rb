# frozen_string_literal: true

require './linked_list'
require './node'

class HashMap
  attr_accessor :load_factor, :capacity

  def initialize(load_factor = 0.75)
    @load_factor = load_factor
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
    l_i = @map[index].find_k(key) unless @map[index].nil?
    if l_i
      node = @map[index].at(l_i)
      node.value = value
      return
    elsif (length + 1) > (@load_factor * @capacity)
      grow_hash_map
    end
    if @map[index].nil?
      @map[index] = start_list(key, value)
    else
      @map[index].append(key, value)
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

    true
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

  def length
    index = 0
    count = 0
    while index < @map.length
      count += @map[index].size unless @map[index].nil?
      index += 1
    end
    count
  end

  def clear
    @map = []
  end

  def keys
    keys = []
    traverse_hash_map { |node| keys << node.value[0] } 
    keys
  end

  def values
    values = []
    traverse_hash_map { |node| values << node.value[1]}
    values
  end

  def entries
    entries = []
    traverse_hash_map {|node| entries << node.value }
    entries
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

  def traverse_hash_map
    index = 0
    while index < @map.length
      unless @map[index].nil?
        @map[index].traverse_list do |node| 
          yield(node)
        end
      end
      index += 1
    end
  end

  # def to_array
  #   array = []
  #   traverse_hash_map do |list|
  #     array += yield(list) unless list.nil?
  #   end
  #   array
  # end

  def grow_hash_map
    k_vs = entries
    @capacity *= 2
    clear
    k_vs.each do |entry|
      set(entry[0], entry[1])
    end
  end
end
