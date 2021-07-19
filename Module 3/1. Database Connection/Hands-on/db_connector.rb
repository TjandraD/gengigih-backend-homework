require 'mysql2'
require_relative 'item'
require_relative 'category'

def create_db_client
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "tjandra",
        :password => "",
        :database => "food_oms_db",
    )

    client
end

def get_all_items()
    client = create_db_client
    rawData = client.query("SELECT * FROM items")
    items = Array.new
    rawData.each do |data|
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    items
end

def get_all_categories()
    client = create_db_client
    rawData = client.query("SELECT * FROM categories")
    categories = Array.new
    rawData.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end

def get_items_with_categories()
    client = create_db_client
    rawData = client.query(
        "SELECT i.id, i.name, i.price, c.id AS \'category_id\', c.name AS \'category_name\'
        FROM items i
        JOIN item_categories ic ON i.id = ic.item_id
        JOIN categories c ON c.id = ic.category_id
        ORDER BY i.id ASC")
    items = Array.new
    rawData.each do |data|
        category = Category.new(data["category_id"], data["category_name"])
        item = Item.new(data["id"], data["name"], data["price"], data["category_name"])
        items.push(item)
    end
    items
end

def get_particular_items(client)
    puts "4. Items that are cheaper than a price"
    # Ask the max price for item
    print "Show items that cheaper than: "
    price = gets.to_i
    puts "\n"

    particular_items = client.query(
        "SELECT * FROM items
        WHERE price < #{price}")
    puts "Items that cheaper than #{price} are:"
    puts particular_items.each
end

def insert_item(name, price)
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{name}', #{price})")
end

def insert_item_and_category(name, price, category_id)
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{name}', #{price})")

    item_id = client.last_id
    client.query("INSERT INTO item_categories VALUES(#{item_id}, #{category_id})")
end