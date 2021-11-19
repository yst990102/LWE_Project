function first_significant_bit = GetFirstSignificantBit(bit_array)
    [~, array_length] = size(bit_array);
    for i = 1 : array_length
        if bit_array(i) == '1'
            first_significant_bit = array_length - i;
            return;
        end
    end
end

