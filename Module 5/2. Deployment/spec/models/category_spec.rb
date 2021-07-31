require_relative '../../models/category'

describe Category do
    before(:each) do
        @mock_client = double
        @category = Category.new(id: 1, name: "Something")
        allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    end

    describe 'get category' do
        context 'when get all categories' do
            it 'should return all categories' do
                mock_query = "SELECT * FROM categories ORDER BY id ASC"
                stub_category_params = [{"id": 1, "name": "Something"}]

                expect(@mock_client).to receive(:query).with(mock_query).and_return(stub_category_params)

                @category = Category.get_all_categories

                expect(@category.length).to eq(1)
            end
        end

        context 'when get category by id' do
            it 'should return a category' do
                mock_query = "SELECT * FROM categories WHERE id = 1"
                stub_category_params = {"id": 1, "name": "Something"}

                expect(@mock_client).to receive(:query).with(mock_query).and_return([stub_category_params])

                @category.get_category

                expect(@category.name).to eq(stub_category_params["name"])
            end
        end

        context 'when get category with items' do
            it 'should return a category with items' do
                item = double

                mock_query = "SELECT * FROM categories WHERE id = 1"
                stub_category_params = {"id": 1, "name": "Something"}

                expect(@mock_client).to receive(:query).with(mock_query).and_return([stub_category_params])
                allow(Item).to receive(:new).with({category: 1}).and_return(item)
                expect(item).to receive(:get_items_by_category_id).and_return([{"item_name": "Item name"}])

                @category.get_category_with_items

                expect(@category.name).to eq(stub_category_params["name"])
            end
        end
    end

    describe 'input category' do
        context 'when given valid arguments' do
            it 'should insert category' do
                mock_query = "INSERT INTO categories(name) VALUES ('Something')"

                expect(@mock_client).to receive(:query).with(mock_query)

                @category.insert_category
            end
        end
    end

    describe 'update category' do
        context 'when given valid arguments' do
            it 'should update category' do
                mock_query = "UPDATE categories SET name = 'Something' WHERE id=1"

                expect(@mock_client).to receive(:query).with(mock_query)

                @category.update_category
            end
        end
    end

    describe 'delete category' do
        context 'when given valid arguments' do
            it 'should delete category' do
                mock_query_item_categories = "DELETE FROM item_categories WHERE category_id=1"
                mock_query_categories = "DELETE FROM categories WHERE id=1"

                expect(@mock_client).to receive(:query).with(mock_query_item_categories)
                expect(@mock_client).to receive(:query).with(mock_query_categories)

                @category.delete
            end
        end
    end
end