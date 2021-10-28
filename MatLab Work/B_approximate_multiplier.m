function [Matrix_B] = B_approximate_multiplier(A,s,q)

[A_row, A_col] = size(A);
Matrix_B = zeros(A_row, 1);
for row = 1 : A_row
   for col = 1 : A_col
       Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_Optimized(A(row,col), s(col),8);
   end
end
Matrix_B = mod(Matrix_B,q);
end

