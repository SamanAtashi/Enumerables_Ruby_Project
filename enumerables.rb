module Enumerable
def my_each(arr)
# if it is Array or Hash
# each --> uses for loop to iterate 
# does the thing he wants --> yield
# returns the array
  count=0
for i in arr
  yield(i)

  count+=1
  if count > arr.length
    break
  end
end



end

