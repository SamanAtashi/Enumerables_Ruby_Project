# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable

    def my_each
        if block_given? 
            i=0
            while i<self.length
                    if self.class == Array
                        yield self[i]
                    else
                        yield(self.keys[i],self.values[i])
                    end
            i+=1
            end
        else 
            puts "block was not given"
        end
    end

end
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
