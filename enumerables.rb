# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
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
        elsif [false, nil].include?(item)
          return false
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
        else
          return false if [[nil], [false], [nil,
                                            false], [false, nil]].include?(new_self)

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
        else
          return true if [[nil], [false], [nil,
                                           false], [false, nil]].include?(new_self)

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

  def my_map
    return enum_for(:my_map) unless block_given?

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

  def my_inject(*sth)
    new_arr = self
    if block_given?
      now_it_is = sth[0] if sth.length == 1
      now_it_is = new_arr.shift unless sth.nil? || sth.length == 1
      new_arr.my_each do |item|
        now_it_is = yield(now_it_is, item)
      end
    else
      now_it_is = sth.length > 1 ? sth.shift : new_arr.shift
      new_arr.my_each do |item|
        now_it_is = now_it_is.send(sth[0].to_s, item)
      end
      return now_it_is
    end
    now_it_is
  end
end

def multiply_els(sth)
  sth.my_inject(:*)
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
