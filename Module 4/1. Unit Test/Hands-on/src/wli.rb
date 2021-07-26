class WLI
    attr_writer :names

    def likes
        sentence = ''

        if (@names.nil?)
            sentence = "No one likes this"
        elsif (@names.length == 1)
            sentence = "#{@names.first} likes this"
        elsif (@names.length <= 3)
            @names.each_with_index do |name, index|
                if (index < @names.length - 2)
                    sentence += "#{name}, "
                elsif (index == @names.length - 2)
                    sentence += name
                else
                    sentence += " and #{name} like this"
                end
            end
        else
            sentence = "#{@names.first}, #{@names[1]} and #{@names.length - 2} others like this"
        end

        sentence
    end
end