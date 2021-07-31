require_relative '../../models/item'

describe Item do
    describe '#initialization' do
        context 'initialized with wrong number of arguments' do
            it 'should return false' do
                item = Item.new({id: 1})

                result = item.valid?

                expect(result).to be_falsey
            end
        end
    end
end