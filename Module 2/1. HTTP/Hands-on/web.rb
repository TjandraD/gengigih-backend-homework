require 'sinatra'

get '/messages/:name' do
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    erb :message, locals: {
        color: color,
        name: name
    }
end

post '/login' do
    if params['username'] == 'admin' && params['password'] == 'admin'
        return 'Logged in!'
    else
        return 'Failed to log in'
    end
end

list_items = []

get '/items' do
    erb :form, locals: {
        items: list_items
    }
end

post '/items' do
    name = params['name']
    price = params['price']

    current_data = {'name' => name, 'price' => price}

    list_items.append(current_data)

    redirect '/items'
end