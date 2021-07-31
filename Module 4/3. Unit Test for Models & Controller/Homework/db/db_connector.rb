require 'mysql2'
require 'dotenv'

def create_db_client
    Dotenv.load
    
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => ENV["DB_USERNAME"],
        :password => ENV["DB_PASSWORD"],
        :database => ENV["DB_DATABASE"],
    )

    client
end