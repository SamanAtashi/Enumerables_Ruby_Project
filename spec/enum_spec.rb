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

     describe '#my_each_with_index' do
        it 'iterates over every element with its index' do
            expect(int_arr.my_each_with_index{ |item, index| item if index.even? }).to eql([1,2,3,4,5])
        end
        it 'returns Enumerator if no block given'do
        expect(int_arr.my_each_with_index).to be_a(Enumerator)
       end
    end
    
    describe '#my_select' do
        it 'returns new array of elements in an array that meet a certain criteria' do
        expect(int_arr.my_select{|x| x.even?}).to eql([2,4])
        expect(int_arr.my_select{|x| !x.even?}).to eql([1,3,5])
        end
        it 'returns new array of elements in an array that meet a certain criteria' do
            expect(combined_arr.my_select{|x| x.nil?}).to eql([nil])
            expect(combined_arr.my_select{|x| !x.nil?}).to eql([10,true])
        end
       end