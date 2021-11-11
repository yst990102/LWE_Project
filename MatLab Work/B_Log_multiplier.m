function [Matrix_B] = B_Log_multiplier(A,s,q)
    [A_row, A_col] = size(A);
    Matrix_B = zeros(A_row,1);
    
    for row = 1:A_row
        for col = 1:A_col
            Matrix_B(row) = Matrix_B(row) + 2^(log2(A(row, col)) + log2(s(col)));
        end
    end
Matrix_B = mod(Matrix_B, q);
end

