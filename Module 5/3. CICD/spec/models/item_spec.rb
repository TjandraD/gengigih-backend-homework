require_relative '../../models/item'

describe Item do
    before(:each) do
        @mock_client = double
        @item = Item.new(id: 1, name: "Something", price: 2000)
        allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    end

    describe 'get items' do
        context 'when get all items' do
            it 'should return all items' do
                mock_query = "SELECT * FROM items ORDER BY id ASC"
                stub_category_params = [{"id": 1, "name": "Something", "price": 2000}]

                expect(@mock_client).to receive(:query).with(mock_query).and_return(stub_category_params)

                @item = Item.get_all_items

                expect(@item.length).to eq(1)
            end
        end

        context 'when get item with categories' do
            it 'should return an item with categories' do
                mock_query_items = "SELECT * FROM items WHERE id = 1"
                mock_query_categories = "SELECT c.name AS \'category_name'\ FROM item_categories ic JOIN categories c ON c.id = ic.category_id WHERE item_id = 1"
                stub_category_params = [{"id": 1, "name": "Something", "price": 2000}]

                expect(@mock_client).to receive(:query).with(mock_query_items).and_return(stub_category_params)
                expect(@mock_client).to receive(:query).with(mock_query_categories).and_return([{"category_name" => "Something"}, {"category_name" => "Another"}])

                @item.get_item_with_category
            end
        end
        
        context 'when get items with categories' do
            it 'should return all items with categories' do
                mock_query_items = "SELECT * FROM items ORDER BY id ASC"
                mock_query_categories = "SELECT c.name AS \'category_name'\ FROM item_categories ic JOIN categories c ON c.id = ic.category_id WHERE item_id = "
                stub_category_params = [{"id": 1, "name": "Something", "price": 2000}]

                expect(@mock_client).to receive(:query).with(mock_query_items).and_return(stub_category_params)
                expect(@mock_client).to receive(:query).with(mock_query_categories).and_return([{"category_name" => "Something"}, {"category_name" => "Another"}])

                @item = Item.get_items_with_categories
            end
        end

        context 'when get items by category id' do
            it 'should return all items by a category id' do
                mock_query = "SELECT i.name AS \'item_name\' FROM items i JOIN item_categories ic ON ic.item_id = i.id WHERE ic.category_id = "

                expect(@mock_client).to receive(:query).with(mock_query)

                @item.get_items_by_category_id
            end
        end
    end

    describe 'input item' do
        context 'when given valid arguments' do
            it 'should insert item' do
                mock_query_item = "INSERT INTO items(name, price) VALUES('Something', 2000)"
                mock_query_category = "INSERT INTO item_categories VALUES(1, )"

                allow(@mock_client).to receive(:last_id).and_return(1)
                expect(@mock_client).to receive(:query).with(mock_query_item)
                expect(@mock_client).to receive(:query).with(mock_query_category)

                @item.insert_item_and_category
            end
        end
    end

    describe 'update item' do
        context 'when given valid arguments' do
            it 'should update item' do
                mock_query_item = "UPDATE items SET name = 'Something', price = 2000 WHERE id = 1"
                mock_query_category = "UPDATE item_categories SET category_id =  WHERE item_id = 1"

                expect(@mock_client).to receive(:query).with(mock_query_item)
                expect(@mock_client).to receive(:query).with(mock_query_category)

                @item.update_item_and_category
            end
        end
    end

    describe 'delete item' do
        context 'when given valid arguments' do
            it 'should delete item' do
                mock_query_item = "DELETE FROM items WHERE id = 1"
                mock_query_category = "DELETE FROM item_categories WHERE item_id = 1"

                expect(@mock_client).to receive(:query).with(mock_query_item)
                expect(@mock_client).to receive(:query).with(mock_query_category)

                @item.delete_item
            end
        end
    end
end