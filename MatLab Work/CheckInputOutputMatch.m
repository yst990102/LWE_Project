function [result] = CheckInputOutputMatch(binary_string,output_matrix)
    if isa(binary_string, 'char') == 0
        class(binary_string)
        error("binary_string is not chars.")
    end
    
    if isa(output_matrix, 'double') == 0
        class(output_matrix)
        error("output_matrix is not matrix of double.")
    end
    
    [rows, cols] = size(binary_string);
    for i = 1:rows
        for j = 1:cols
            if (binary_string(i,j) == '0') && (output_matrix(i,j) == 0)
                continue
            elseif (binary_string(i,j) == '1') && (output_matrix(i,j) == 1)
                continue
            else
                result = false;
                return
            end
        end
    end
    
    result = true;
end

