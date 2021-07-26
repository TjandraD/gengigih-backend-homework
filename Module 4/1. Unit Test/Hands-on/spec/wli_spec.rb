require_relative '../src/wli'

RSpec.describe WLI do
    it 'return empty name' do
        # given
        wli = WLI.new

        # when
        # Name isn't initialized

        # then
        expect(wli.likes).to eq("No one likes this")
    end

    it 'return a name' do
        # given
        wli = WLI.new

        # when
        wli.names = ["Peter"]

        # then
        expect(wli.likes).to eq("Peter likes this")
    end

    it 'return 2 names' do
        # given
        wli = WLI.new

        # when
        wli.names = ['Andre', 'Alyssa']

        # then
        expect(wli.likes).to eq("Andre and Alyssa like this")
    end

    it 'return 3 names' do
        # given
        wli = WLI.new

        # when
        wli.names = ['Andre', 'Alyssa', 'Natasha']

        # then
        expect(wli.likes).to eq("Andre, Alyssa and Natasha like this")
    end

    it 'return many names' do
        # given
        wli = WLI.new

        # when
        wli.names = ['Andre', 'Alyssa', 'Natasha', 'Pietro']

        # then
        expect(wli.likes).to eq("Andre, Alyssa and 2 others like this")
    end
end