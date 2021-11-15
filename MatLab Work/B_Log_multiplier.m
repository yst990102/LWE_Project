function Matrix_B = B_Log_multiplier(A,s,q, LUT_int,LUT_fra)
    [A_row, A_col] = size(A);
    Matrix_B = zeros(A_row,1);
    
    for row = 1:A_row
        for col = 1:A_col
            Matrix_B(row) = Matrix_B(row) + 2^((LUT_int(A(row, col)) + LUT_fra(A(row,col))) + (LUT_int(s(col)) + LUT_fra(s(col))));
        end
    end
Matrix_B = mod(Matrix_B, q);
end

