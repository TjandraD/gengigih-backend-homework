require 'sinatra'
require_relative 'db_connector'

get '/' do
    items = get_items_with_categories
    erb :index, locals: {
        items: items
    }
end

get '/items/new' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/new' do
    name = params["name"]
    price = params["price"]
    category = params["category"]
    insert_item_and_category(name, price, category)

    redirect '/'
end

get '/items/details/:id' do
    item_id = params["id"]
    item = get_item_with_category(item_id)
    erb :details, locals: {
        item: item
    }
end

get '/items/edit/:id' do
    item_id = params["id"]
    item = get_item_with_category(item_id)
    categories = get_all_categories
    erb :edit, locals: {
        item: item,
        categories: categories
    }
end

put '/items/edit/:id' do
    id = params["id"]
    name = params["name"]
    price = params["price"]
    category = params["category"]
    update_item_and_category(id, name, price, category)

    redirect '/'
end

get '/items/delete/:id' do
    item_id = params["id"]
    delete_item(item_id)

    redirect '/'
end