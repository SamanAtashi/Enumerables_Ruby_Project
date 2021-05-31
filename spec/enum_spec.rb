require_relative '../enumerables'

describe Enumerable do
    let(:int_arr) { [1, 2, 3, 4, 5] }
    let(:str_arr) { %w[dog cat matatu] }
    let(:combined_arr) { [10, true, nil] }
    let(:empty_arr) { [] }
    
     describe'#my_each' do
         it 'iterate  through every element' do
             expect(int_arr.my_each {|x|x*2}).to eql([1,2,3,4,5])
             expect(str_arr.my_each(&:to_s)).to eql(%w[dog cat matatu])
         end
         it 'returns Enumerator if no block given'do
             expect(int_arr.my_each).to be_a(Enumerator)
         end
     end