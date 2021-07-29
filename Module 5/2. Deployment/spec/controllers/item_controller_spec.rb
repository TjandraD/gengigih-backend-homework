require_relative '../../controllers/item_controller'

describe ItemController do
    before(:each) do
        @controller = ItemController.new
    end

    describe 'list' do
        context 'list items categories' do
            it 'should return index page' do
                items = double
                categories = double

                allow(Item).to receive(:get_items_with_categories).and_return(items)
                allow(items).to receive(:each)
                allow(items).to receive(:id)
                allow(items).to receive(:name)
                allow(items).to receive(:price)
                allow(items).to receive(:category)

                allow(Category).to receive(:get_all_categories).and_return(categories)
                allow(categories).to receive(:each)
                allow(categories).to receive(:id)
                allow(categories).to receive(:name)

                expected_result = ERB.new(File.read("./views/index.erb"))

                expect(@controller.list_items_categories).to eq(expected_result.result_with_hash(
                    items: items, categories: categories
                ))
            end
        end

        context 'details item' do
            it 'should return details item list' do
                item = double
                expected_result = ERB.new(File.read("./views/item_details.erb"))

                allow(Item).to receive(:new).with([]).and_return(item)
                expect(item).to receive(:get_item_with_category).and_return(item)
                allow(item).to receive(:id)
                allow(item).to receive(:name)
                allow(item).to receive(:price)
                allow(item).to receive(:category)

                expect(@controller.item_details([])).to eq(expected_result.result_with_hash(item: item))
            end
        end
    end

    describe 'form' do
        context 'new item' do
            it 'should return new item form' do
                categories = double

                allow(Category).to receive(:get_all_categories).and_return(categories)
                allow(categories).to receive(:each)
                allow(categories).to receive(:id)
                
                expected_result = ERB.new(File.read("./views/create_item.erb"))

                expect(@controller.new_item_form).to eq(expected_result.result_with_hash(categories: categories))
            end
        end

        context 'edit item' do
            it 'should return edit item form' do
                categories = double
                item = double

                allow(Category).to receive(:get_all_categories).and_return(categories)
                allow(categories).to receive(:each)
                allow(categories).to receive(:id)

                allow(Item).to receive(:new).with([]).and_return(item)
                expect(item).to receive(:get_item_with_category).and_return(item)
                allow(item).to receive(:id)
                allow(item).to receive(:name)
                allow(item).to receive(:price)
                allow(item).to receive(:category)
                
                expected_result = ERB.new(File.read("./views/edit_item.erb"))

                expect(@controller.edit_item_form([])).to eq(expected_result.result_with_hash(categories: categories, item: item))
            end
        end
    end

    describe 'input' do
        context 'item' do
            it 'should call insert new item method' do
                stub_model = double

                allow(Item).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:insert_item_and_category)

                @controller.new_item([])
            end
        end
    end

    describe 'edit' do
        context 'item' do
            it 'should call edit item method' do
                stub_model = double

                allow(Item).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:update_item_and_category)

                @controller.edit_item([])
            end
        end
    end

    describe 'delete' do
        context 'item' do
            it 'should call delete item method' do
                stub_model = double

                allow(Item).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:delete_item)

                @controller.delete_item([])
            end
        end
    end
end