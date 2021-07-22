require 'sinatra'
require_relative 'models/item'
require_relative 'models/category'

get '/' do
    items = Item.get_items_with_categories
    erb :index, locals: {
        items: items
    }
end

get '/items/new' do
    categories = Category.get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/new' do
    name = params["name"]
    price = params["price"]
    category = params["category"]
    item = Item.new(nil, name, price, category)
    item.insert_item_and_category

    redirect '/'
end

get '/items/details/:id' do
    item_id = params["id"]
    item = Item.new(item_id)
    item = item.get_item_with_category
    erb :details, locals: {
        item: item
    }
end

get '/items/edit/:id' do
    item_id = params["id"]
    item = Item.new(item_id)
    item = item.get_item_with_category
    categories = Category.get_all_categories
    erb :edit, locals: {
        item: item,
        categories: categories
    }
end

post '/items/edit/:id' do
    id = params["id"]
    name = params["name"]
    price = params["price"]
    category = params["category"]
    item = Item.new(id, name, price, category)
    item.update_item_and_category

    redirect '/'
end

get '/items/delete/:id' do
    item_id = params["id"]
    item = Item.new(item_id)
    item.delete_item

    redirect '/'
end