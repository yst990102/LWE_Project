function [decoded_string] = BinaryArrayToString(BinaryArray)
    [row, ~] = size(BinaryArray);
    decoded_string = "";
    for i = 1 : row
        bin_vector = num2str(BinaryArray(i,:));
        bin_vector(isspace(bin_vector)) = '';
        decoded_char = char(bin2dec(bin_vector));
        decoded_string = append(decoded_string, decoded_char);
    end
end

