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
end
