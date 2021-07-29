require_relative '../db/db_connector'
require_relative 'item'

class Category
    attr_reader :id, :name, :items

    def initialize(params)
        @id = params[:id]
        @name = params[:name]
        @items = params[:items]
    end

    def self.get_all_categories()
        client = create_db_client
        rawData = client.query("SELECT * FROM categories ORDER BY id ASC")
        categories = Array.new
        rawData.each do |data|
            category = Category.new({id: data["id"], name: data["name"]})
            categories.push(category)
        end
        categories
    end

    def get_category
        client = create_db_client
        rawData = client.query("SELECT * FROM categories WHERE id = 1")
        data = rawData.first
        
        @name = data["name"]
    end

    def insert_category
        client = create_db_client
        client.query("INSERT INTO categories(name) VALUES ('#{@name}')")
    end

    def update_category
        client = create_db_client
        client.query("UPDATE categories SET name = '#{@name}' WHERE id=#{@id}")
    end

    def get_category_with_items
        client = create_db_client
        rawData = client.query("SELECT * FROM categories WHERE id = #{@id}")
        data = rawData.first

        item = Item.new({category: @id})
        itemData = item.get_items_by_category_id
        
        items = Array.new
        itemData.each do |item|
            items.push(item["item_name"])
        end

        @name = data["name"]
        @items = items
    end

    def delete
        client = create_db_client
        client.query("DELETE FROM item_categories WHERE category_id=#{@id}")
        client.query("DELETE FROM categories WHERE id=#{@id}")
    end
end