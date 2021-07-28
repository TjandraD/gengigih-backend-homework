require 'rspec'
require 'simplecov'
require_relative '../src/array_increment'

SimpleCov.start

RSpec.describe ArrayIncrement do
    it 'should returns [5, 6, 2] when given [5, 6, 1]' do
        array_increment = ArrayIncrement.new([5, 6, 1])

        response = array_increment.plus_one

        expect(response).to eq([5, 6, 2])
    end
end