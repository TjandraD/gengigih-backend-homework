require_relative '../db/db_connector'

class Category
    attr_reader :id, :name

    def initialize(params)
        @id = params[:id]
        @name = params[:name]
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

    def insert_category
        client = create_db_client
        client.query("INSERT INTO categories(name) VALUES ('#{@name}')")
    end

    def update_category
        client = create_db_client
        client.query("UPDATE categories SET name = '#{@name}'")
    end
end