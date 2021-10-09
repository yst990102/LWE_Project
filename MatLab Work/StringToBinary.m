function [binary_string] = StringToBinary(input_string, bit_num)
    if isa(input_string, 'string') && isa(bit_num, 'double')
        binary_string = dec2bin(char(input_string), bit_num);
    elseif ~isa(input_string, 'string') && isa(bit_num, 'double')
        error("Input Error: You have to enter a String!");
    elseif ~isa(bit_num, 'double') && isa(input_string, 'string')
        error("Input Error: Bit_num should be Double!");
    else
        error("Extra Input Error!");
    end
end

