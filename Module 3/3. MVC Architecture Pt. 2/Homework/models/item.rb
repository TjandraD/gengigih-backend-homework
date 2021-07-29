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
            item = Item.new({id: data["id"], name: data["name"], price: data["price"]})
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
            "SELECT *
            FROM items
            WHERE id = #{@id}")
        
        rawCategoryData = client.query(
            "SELECT c.name AS \'category_name'\
            FROM item_categories ic
            JOIN categories c ON c.id = ic.category_id
            WHERE item_id = #{@id}"
        )

        categories = "No category"
        rawCategoryData.each do |category|
            if categories == "No category"
                categories = category["category_name"]
                next
            end
            categories += ", #{category["category_name"]}"
        end
    
        data = rawData.first()
        item = Item.new({id: data["id"], name: data["name"], price: data["price"], category: categories})
        item
    end
    
    def self.get_items_with_categories
        client = create_db_client
        rawItemData = client.query(
            "SELECT *
            FROM items
            ORDER BY id ASC")

        items = Array.new
        rawItemData.each do |data|
            rawCategoryData = client.query(
                "SELECT c.name AS \'category_name'\
                FROM item_categories ic
                JOIN categories c ON c.id = ic.category_id
                WHERE item_id = #{data["id"]}"
            )

            categories = "No category"
            rawCategoryData.each do |category|
                if categories == "No category"
                    categories = category["category_name"]
                    next
                end
                categories += ", #{category["category_name"]}"
            end

            item = Item.new({id: data["id"], name: data["name"], price: data["price"], category: categories})
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