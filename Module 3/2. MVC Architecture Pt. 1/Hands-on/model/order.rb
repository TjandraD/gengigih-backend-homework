require_relative '../db/db_connector'

class Order
    attr_accessor :reference_no, :customer_name, :date

    def initialize(reference_no, customer_name, date)
        @reference_no = reference_no
        @customer_name = customer_name
        @date = date
    end

    def self.get_all_orders
        client = create_db_client
        raw_data = client.query("SELECT * FROM orders")
        orders = Array.new
        raw_data.each do |order|
            orders.push(Order.new(order["reference_no"], order["customer_name"], order["date"]))
        end
        orders
    end

    def save
        return false unless valid?

        client = create_db_client
        client.query("INSERT INTO orders(reference_no, customer_name, date) VALUES ('#{@reference_no}', '#{@customer_name}', '#{@date}')")
    end

    def valid?
        return false if @reference_no.nil?
        return false if @customer_name.nil?
        return false if @date.nil?
        true
    end
end