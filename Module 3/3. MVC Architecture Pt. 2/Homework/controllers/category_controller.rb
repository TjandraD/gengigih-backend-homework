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

    def edit_category_form
        renderer = ERB.new(File.read("./views/edit_category.erb"))
        renderer.result(binding)
    end

    def edit_category(params)
        category = Category.new(params)
        category.insert_category
    end
end