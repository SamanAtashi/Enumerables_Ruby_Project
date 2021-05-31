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

       describe '#my_all?' do
        it 'returns true if all elements matches the condition in the original array' do
            expect(int_arr.my_all?(Numeric)).to eql(true)
       end
       it 'returns true if all elements matches the condition in the original array' do
        expect(str_arr.my_all?{ |word| word.length >= 3 }).to eql(true)
        expect(str_arr.my_all?{ |word| word.length >= 5 }).to eql(false)
       end
       it 'returns true if all elements matches the condition in the original array' do
        expect(combined_arr.my_all?).to eql(false)
        expect(empty_arr.my_all?).to eql(true)
       end
    end
    
    describe '#my_any?' do
        it 'returns true if atleast one element matches the requirements' do
          expect(int_arr.my_any?{ |n| n > 3 }).to eql(true)
          expect(int_arr.my_any?{ |n| n > 5 }).to eql(false)
          expect(int_arr.my_any?).to eql(true)
        end
        it 'returns true if atleast one element matches the requirements' do
          expect(str_arr.my_any?('matatu')).to eql(true)
          expect(str_arr.my_any?('faith')).to eql(false)
          expect(combined_arr.my_any?(nil)).to eql(true)
       end
    end
    
    describe '#my_none?' do
        it 'returns true if no element matches the condition' do
            expect(int_arr.my_none?(Float)).to eql(true)
            expect(int_arr.my_none?(Numeric)).to eql(false)
        end
        it 'returns true if no element matches the condition' do
            expect(str_arr.my_none?{ |word| word.length == 5 }).to eql(true)
            expect(str_arr.my_none?{ |word| word.length >= 3 }).to eql(false)
        end
        it 'returns true if no element matches the condition' do
            expect(combined_arr.my_none?).to eql(false)
             expect(empty_arr.my_none?).to eql(true)
        end
       end
    
       describe'#my_count' do
        it 'returns the number of items in an array' do
            expect(int_arr.my_count).to eql (5)
            expect(int_arr.my_count(2)).to eql (1)
            expect(int_arr.my_count{ |x| x%2==0 }).to eql (2)
        end
        it 'returns the number of items in an array' do
            expect(str_arr.my_count).to eql(3)
            expect(str_arr.my_count('matatu')).to eql(1)
        end
    end

    describe '#my_map' do
        it 'returns new array after calling the block given' do
            expect(int_arr.my_map { |item| item**2 }).to eql([1, 4, 9, 16, 25])
        end
        it 'returns an enumerator if no block given' do
            expect(int_arr.my_map).to be_a(Enumerator)
          end
    end

    describe '#my_inject' do
        it 'returns result of using symbol when no block is given' do
            expect(int_arr.my_inject(:+)).to eql(15)
            expect(int_arr.my_inject(20, :+)).to eql(35)
          end
          it 'raises LocalJumpError if no block or proc given or works with block or with 2 arguments' do
            expect { int_arr.my_inject }.to raise_error(LocalJumpError)
          end
    end