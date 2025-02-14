# frozen_string_literal: true

# holds value and point to a next node
class Node
  attr_accessor :next_node, :value
  attr_reader :key

  def initialize(key, value = nil)
    @key = key
    @value = value
    @next_node = nil
  end
end