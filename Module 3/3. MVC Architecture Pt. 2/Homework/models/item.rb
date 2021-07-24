require_relative '../db/db_connector'
require_relative 'category'

class Item
    attr_reader :id, :name, :price, :category

    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @price = params[:price]
        @category = params[:category]
    end

    def self.get_all_items
        client = create_db_client
        rawData = client.query("SELECT * FROM items ORDER BY id ASC")
        items = Array.new
        rawData.each do |data|
            item = Item.new({id: data["id"], id: data["name"], id: data["price"]})
            items.push(item)
        end
        items
    end

    def insert_item()
        client = create_db_client
        client.query("INSERT INTO items(name, price) VALUES('#{@name}', #{@price})")
    end

    def get_item_with_category()
        client = create_db_client
        rawData = client.query(
            "SELECT i.id, i.name, i.price, GROUP_CONCAT(c.id) AS \'category_id\', GROUP_CONCAT(c.name SEPARATOR ' ') AS \'category_name\'
            FROM items i
            JOIN item_categories ic ON i.id = ic.item_id
            JOIN categories c ON c.id = ic.category_id
            WHERE i.id = #{@id}
            GROUP BY ic.category_id")
    
        data = rawData.first()
        category = Category.new({id: data["category_id"], name: data["category_name"]})
        item = Item.new({id: data["id"], name: data["name"], price: data["price"], category: category})
        item
    end
    
    def self.get_items_with_categories()
        client = create_db_client
        rawData = client.query(
            "SELECT i.id, i.name, i.price, c.id AS \'category_id\', GROUP_CONCAT(c.name) AS \'category_name\'
            FROM items i
            LEFT JOIN item_categories ic ON i.id = ic.item_id
            JOIN categories c ON c.id = ic.category_id
            GROUP BY ic.category_id, i.id
            ORDER BY i.id ASC")
        items = Array.new
        rawData.each do |data|
            category = Category.new({id: data["category_id"], name: data["category_name"]})
            item = Item.new({id: data["id"], name: data["name"], price: data["price"], category: category})
            items.push(item)
        end
        items
    end
    
    def insert_item_and_category()
        client = create_db_client
        client.query("INSERT INTO items(name, price) VALUES('#{@name}', #{@price})")
    
        item_id = client.last_id
        client.query("INSERT INTO item_categories VALUES(#{item_id}, #{@category})")
    end
    
    def update_item_and_category()
        client = create_db_client
        client.query("UPDATE items SET name = '#{@name}', price = #{@price} WHERE id = #{@id}")
    
        client.query("UPDATE item_categories SET category_id = #{@category} WHERE item_id = #{@id}")
    end
    
    def delete_item()
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE item_id = #{@id}")
        client.query("DELETE FROM items WHERE id = #{@id}")
    end
end