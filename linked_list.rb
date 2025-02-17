# frozen_string_literal: true

require './node'
# represent and manages full list of nodes
class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(key, value)
    return @head = Node.new(key, value) if @head.nil?

    traverse_list do |node|
      return node.next_node = Node.new(key, value) if node.next_node.nil?
    end
  end

  def prepend(key, value)
    new_node = Node.new(key, value)
    new_node.next_node = @head
    @head = new_node
  end

  def size
    size = 0
    traverse_list { size += 1 }
    size
  end

  def tail
    traverse_list do |node|
      return node if node.next_node.nil?
    end
  end

  def at(index)
    i = 0
    traverse_list do |node|
      return node if i == index

      i += 1
    end
  end

  def pop
    traverse_list do |node|
      node.next_node = nil if node.next_node.next_node.nil?
    end
  end

  def contains_v?(value)
    traverse_list do |node|
      return true if node.value == value
    end
    false
  end

  def contains_k?(key)
    traverse_list do |node|
      return true if node.key == key
    end
    false
  end

  def find(value)
    i = 0
    traverse_list do |node|
      return i if node.value == value

      i += 1
    end
  end

  def find_k(key)
    i = 0
    traverse_list do |node|
      return i if node.key == key

      i += 1
    end
  end

  def to_s
    string = ''
    traverse_list do |node|
      string += "(#{node.value}) -> "
    end
    string += '(nil)'
  end

  def insert_at(key, value, index)
    return prepend(key, value) if index.zero?

    i = 0
    traverse_list do |node|
      return insert_between(Node.new(key, value), node, node.next_node) if i == index - 1

      i += 1
    end
  end

  def remove_at(index)
    return @head = @head.next_node if index.zero?

    i = 0
    traverse_list do |node|
      return node.next_node = node.next_node.next_node if i == index - 1 && !node.next_node.nil?

      i += 1
    end
  end

  def array_k
    keys = []
    traverse_list {|node|keys << node.key}
    keys
  end

  # private

  def traverse_list
    curr = @head
    until curr.nil?
      yield(curr)
      curr = curr.next_node
    end
  end

  def insert_between(new_node, node_before, node_after)
    new_node.next_node = node_after
    node_before.next_node = new_node
  end

  def to_array
    array = []
    traverse_list {|node| array << yield(node)}
    array
  end
end
