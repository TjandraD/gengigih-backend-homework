class ArrayIncrement
    def initialize(params)
        @first_num = params[0]
        @second_num = params[1]
        @third_num = params[2]
    end

    def return_array
        if (@third_num.nil?)
            two_inputs
        else
            three_inputs
        end
    end

    def three_inputs
        @third_num += 1
        
        response = [@first_num, @second_num, @third_num]
    end

    def two_inputs
        @second_num += 1

        if @second_num >= 10
            @second_num -= 10
            @first_num += 1

            if @first_num >= 10
                @first_num -= 9
                @third_num = 0
    
                return [@first_num, @second_num, @third_num]
            end

            return [@first_num, @second_num]
        end
    end
end