function [binary_string] = StringToBinaryArray(input_string, bit_num)
    if isa(input_string, 'string') && isa(bit_num, 'double')
        binary_string = dec2bin(char(input_string), bit_num);
    elseif isa(input_string, 'string') == 0
        error("StringToBinary: Input Error - You have to enter a String!");
    elseif isa(bit_num, 'double') == 0
        error("StringToBinary: Input Error - Bit_num should be Double!");
    else
        error("StringToBinary: Extra Input Error!");
    end
end

