class ArrayIncrement
    def initialize(params)
        @array = params
    end

    def return_array
        @array.each_with_index do |number, index|
            next if index != (@array.length - 1)
            number += 1
            @array[index] = number

            if number >= 10
                @more_than_ten = true
                @num_position = index
            end
        end

        array_formatter if @more_than_ten

        return @array
    end

    def array_formatter
        @next_position = @num_position - 1
        @array[@next_position] += 1
        @array[@num_position] -= 10

        if @array[@next_position] >= 10
            @array[@next_position] -= 9
            @array[@array.length] = 0
        end
    end
end