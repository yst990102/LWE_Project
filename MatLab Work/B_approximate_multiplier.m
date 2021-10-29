function [Matrix_B] = B_approximate_multiplier(A,s,q,multi_choice)

if ~ismember(multi_choice, [1,2,3])
    error("你瞎啊，输个123能死啊？")
end

[A_row, A_col] = size(A);
Matrix_B = zeros(A_row, 1);
for row = 1 : A_row
   for col = 1 : A_col
       if multi_choice == 1
           Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_MBM_t(A(row,col), s(col),16, 16);
       elseif multi_choice == 2
           Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_Optimized(A(row,col), s(col),16);
       elseif multi_choice == 3
           Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_REALM8x8_t(A(row,col), s(col),16, 16);
       end
   end
end
Matrix_B = mod(Matrix_B,q);
end

