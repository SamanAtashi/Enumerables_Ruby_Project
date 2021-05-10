# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/BlockNesting
# rubocop:disable Lint/ToEnumArguments
# rubocop:disable Lint/DuplicateBranch
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    i = 0
    new_arr = *self
    while i < new_arr.length
      if new_arr.instance_of?(Array)
        yield new_arr[i]
      elsif new_arr.instance_of?(Hash)
        yield(new_arr.keys[i], new_arr.values[i])
      end
      i += 1
    end
    self if instance_of?(Array) || instance_of?(Range)
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    i = 0
    my_each do |item|
      yield(item, i)
      i += 1
    end
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    new_self = *self

    new_arr = []
    new_hash = {}
    if instance_of?(Hash)
      j = 0
      while j < length
        new_hash[keys[j]] = values[j] if yield(keys[j], values[j])
        j += 1
      end
      new_hash
    elsif new_self.instance_of?(Array)
      i = 0
      while i < new_self.length
        new_arr << new_self[i] if yield new_self[i]
        i += 1
      end
      new_arr
    end
  end

  def my_all?(sth = nil)
    new_self = *self

    return true if new_self.empty?

    if block_given?
      new_self.my_each do |item|
        return false unless yield item
      end
    else
      new_self.my_each do |item|
        if sth.instance_of?(Regexp)
          return false if item.match?(sth) == false
        elsif sth.is_a? Class
          return false unless item.is_a? sth
        elsif [nil, false].include?(sth)
          if length == 1
            return true if sth == item
          elsif [false, nil].include?(item)
            return false
          end
        else
          return false unless item == sth
        end
      end
    end
    true
  end

  def my_any?(sth = nil)
    new_self = *self

    return false if new_self.empty?

    if block_given?
      new_self.my_each do |item|
        return true if yield item
      end
    else
      new_self.my_each do |item|
        if sth.instance_of?(Regexp)
          return true if item.match?(sth)
        elsif sth.is_a? Class
          return true if item.is_a? sth
        elsif sth.nil?
          to_a.my_each { |i| return true if i }
        elsif [true].include?(new_self)
          return true
        elsif sth == item
          return true
        end
      end
    end
    false
  end

  def my_none?(sth = nil)
    new_self = *self

    return true if new_self.empty?

    if block_given?
      new_self.my_each do |item|
        return false if yield item
      end
    else
      new_self.my_each do |item|
        if sth.instance_of?(Regexp)
          return false if item.match?(sth)
        elsif sth.is_a? Class
          return false if item.is_a? sth
        elsif [[nil], [false], [nil, false], [false, nil]].include?(new_self)
          return true
        elsif sth == item
          return false
        end 
      end
    end
    true
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

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    new_arr = []
    if proc
      to_a.my_each do |item|
        new_arr.push(proc.call(item))
      end
    else
      to_a.my_each do |item|
        new_arr.push(yield item)
      end
    end
    new_arr
  end

  def my_inject(accum = nil, current = nil)
    if (!accum.nil? && current.nil?) && (accum.is_a?(Symbol) || accum.is_a?(String))
      current = accum
      accum = nil
    end

    if !block_given? && !current.nil?
      to_a.my_each do |item|
        accum = accum.nil? ? item : accum.send(current, item)
      end
    else
      to_a.my_each do |item|
        accum = accum.nil? ? item : yield(accum, item)
      end
    end
    accum
  end
end

def multiply_els(sth)
  sth.my_inject(:*)
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/BlockNesting
# rubocop:enable Lint/ToEnumArguments
# rubocop:enable Lint/DuplicateBranch
