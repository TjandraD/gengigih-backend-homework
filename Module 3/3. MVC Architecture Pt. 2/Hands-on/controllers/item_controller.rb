require_relative '../models/item'
require_relative '../models/category'

class ItemController
    def list_items
        items = Item.get_items_with_categories

        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def new_item_form
        categories = Category.get_all_categories

        renderer = ERB.new(File.read("./views/create.erb"))
        renderer.result(binding)
    end

    def new_item(params)
        item = Item.new(params)
        item.insert_item_and_category
    end

    def item_details(params)
        item = Item.new(params)
        item = item.get_item_with_category

        renderer = ERB.new(File.read("./views/details.erb"))
        renderer.result(binding)
    end

    def edit_item_form(params)
        item = Item.new(params)
        item = item.get_item_with_category
        categories = Category.get_all_categories

        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
    end

    def edit_item(params)
        item = Item.new(params)
        item.update_item_and_category
    end

    def delete_item(params)
        item = Item.new(params)
        item.delete_item
    end
end