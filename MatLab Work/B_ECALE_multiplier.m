function Matrix_B = B_ECALE_multiplier(A,s,q,logdeltas, expdeltas, k)
    [A_row, A_col] = size(A);
    Matrix_B = zeros(A_row,1);
    
    for row = 1:A_row
        for col = 1:A_col
            Matrix_B(row) = Matrix_B(row) + fn_ECALEMul(A(row, col), s(col), logdeltas, expdeltas, k);
        end
    end
Matrix_B = mod(Matrix_B, q);
end

