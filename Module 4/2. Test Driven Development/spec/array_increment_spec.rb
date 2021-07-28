require 'rspec'
require 'simplecov'
require_relative '../src/array_increment'

SimpleCov.start

RSpec.describe ArrayIncrement do
    it 'should returns [5, 6, 2] when given [5, 6, 1]' do
        array_increment = ArrayIncrement.new([5, 6, 1])

        response = array_increment.return_array

        expect(response).to eq([5, 6, 2])
    end

    it 'should returns [4, 0] when given [3, 9]' do
        array_increment = ArrayIncrement.new([3, 9])

        response = array_increment.return_array

        expect(response).to eq([4, 0])
    end

    it 'should returns [1, 0, 0] when given [9, 9]' do
        array_increment = ArrayIncrement.new([9, 9])

        response = array_increment.return_array

        expect(response).to eq([1, 0, 0])
    end
end