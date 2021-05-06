# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/BlockNesting
module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < length
        if instance_of?(Array)
          yield self[i]
        else
          yield(keys[i], values[i])
        end
        i += 1
      end
    else
      puts 'block was not given'
    end
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < length
        if instance_of?(Array)
          yield(self[i], i)
        else
          yield(values[i], i)
        end
        i += 1
      end
    else
      puts 'block was not given'
    end
  end

  def my_select
    if block_given?
      i = 0
      new_arr = []
      new_hash = {}
      while i < length
        if instance_of?(Array)
          new_arr << self[i] if yield self[i]
        elsif yield(keys[i], values[i])
          new_hash[keys[i]] = values[i]
        end
        i += 1
      end

      return new_arr if instance_of?(Array)
      return new_hash if instance_of?(Hash)

    else
      puts 'block was not given'
    end
  end

  def my_all?(sth = nil)
    return true if empty?

    if block_given?
      my_each do |item|
        return false unless yield item
      end
    else
      my_each do |item|
        if sth.instance_of?(Regexp)
          return false if item.match?(sth) == false
        elsif sth.is_a? Class
          return false unless item.is_a? sth
        elsif [false, nil].include?(item)
          return false
        end
      end
    end
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?
    self.my_each do |i|
      return true if yield i
     end
     false 
 end
 
  def my_count(arg = nil)
    i = 0
    if arg
      my_each do |item|
        i += 1 if item == arg
      end

    elsif block_given?
      my_each do |item|
        i += 1 if yield item
      end

    else
      i = to_a.length
    end
    i
  end

  def my_map
    result = []
    if proc
      to_a.my_each do |item|
        result.push(proc.call(item))
      end
    else
      to_a.my_each do |item|
        result.push(yield item)
      end
    end
    result
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/BlockNesting
