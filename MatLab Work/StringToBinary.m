function [binary_string] = StringToBinary(input_string, bit_num)
    if isa(input_string, 'char') && isa(bit_num, 'double')
        double_string = double(input_string);
        binary_string = dec2bin(double_string, bit_num);
    elseif isa(input_string, 'char') == 0
        error("Input Error: You have to enter a String!");
    elseif isa(bit_num, 'double') == 0
        error("Input Error: Bit_num should be Double!");
    else
        error("Extra Input Error!");
    end
end

