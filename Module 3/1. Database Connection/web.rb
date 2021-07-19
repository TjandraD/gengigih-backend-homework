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

post '/items/create' do
    name = params["name"]
    price = params["price"]
    category = params["category"]
    insert_item_and_category(name, price, category)

    redirect '/'
end