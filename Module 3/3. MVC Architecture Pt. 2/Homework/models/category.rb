require_relative '../db/db_connector'

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
        rawData = client.query("SELECT * FROM categories WHERE id = #{@id}")
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

        itemData = client.query("SELECT i.name AS \'item_name\'
            FROM items i
            JOIN item_categories ic ON ic.item_id = i.id
            WHERE ic.category_id = #{@id}")
        
        items = Array.new
        itemData.each do |item|
            items.push(item["item_name"])
        end

        @name = data["name"]
        @items = items
    end
end