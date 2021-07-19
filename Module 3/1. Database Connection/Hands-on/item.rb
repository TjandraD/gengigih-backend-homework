class Item
    attr_reader :id, :name, :price, :category

    def initialize(id, name, price, category = nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end
end