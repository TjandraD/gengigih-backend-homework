require_relative '../models/category'

class CategoryController
    def new_category_form
        renderer = ERB.new(File.read("./views/create_category.erb"))
        renderer.result(binding)
    end

    def new_category(params)
        category = Category.new(params)
        category.insert_category
    end

    def edit_category_form(params)
        category = Category.new(params)
        category.get_category

        renderer = ERB.new(File.read("./views/edit_category.erb"))
        renderer.result(binding)
    end

    def edit_category(params)
        category = Category.new(params)
        category.update_category
    end

    def category_details(params)
        category = Category.new(params)
        category.get_category_with_items

        renderer = ERB.new(File.read("./views/category_details.erb"))
        renderer.result(binding)
    end
end