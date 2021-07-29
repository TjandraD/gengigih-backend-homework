require_relative '../../controllers/item_controller'
require_relative '../../models/category'
require 'simplecov'

SimpleCov.start

describe ItemController do
    describe '#render' do
        it 'should return new item view only' do
            item_controller = ItemController.new
            categories = Category.get_all_categories

            create_item_view = item_controller.new_item_form

            renderer = ERB.new(File.read("./views/create_item.erb"))

            expect(create_item_view).to eq(renderer.result(binding))
        end
    end
end