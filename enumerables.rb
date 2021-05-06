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
end