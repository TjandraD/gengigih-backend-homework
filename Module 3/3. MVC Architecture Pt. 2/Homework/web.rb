require 'sinatra'
require_relative 'controllers/item_controller'
require_relative 'controllers/category_controller'

get '/' do
    controller = ItemController.new
    controller.list_items_categories
end

get '/items/new' do
    controller = ItemController.new
    controller.new_item_form
end

post '/items/new' do
    name = params["name"]
    price = params["price"]
    category = params["category"]
    
    controller = ItemController.new
    controller.new_item({name: name, price: price, category: category})

    redirect '/'
end

get '/categories/new' do
    controller = CategoryController.new
    controller.new_category_form
end

post '/categories/new' do
    controller = CategoryController.new
    controller.new_category({name: params["name"]})

    redirect '/'
end

get '/items/details/:id' do
    item_id = params["id"]
    controller = ItemController.new
    controller.item_details({id: item_id})
end

get '/items/edit/:id' do
    item_id = params["id"]
    controller = ItemController.new
    controller.edit_item_form({id: item_id})
end

post '/items/edit/:id' do
    id = params["id"]
    name = params["name"]
    price = params["price"]
    category = params["category"]

    controller = ItemController.new
    controller.edit_item({id: id, name: name, price: price, category: category})

    redirect '/'
end

get '/items/delete/:id' do
    controller = ItemController.new
    controller.delete_item({id: params["id"]})

    redirect '/'
end