function B = fn_ECALEMul(A,s,q,logdeltas, expdeltas,k)
[A_row, A_col] = size(A);
B = zeros(A_row,1);
 
for row = 1:A_row
    for col = 1:A_col
        B(row) = B(row) + ecMult(A(row, col), s(col), logdeltas, expdeltas,k);
    end
end
B = mod(B,q);
end

