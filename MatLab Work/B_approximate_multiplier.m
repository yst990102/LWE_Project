function Matrix_B = B_approximate_multiplier(A,s,q,multi_choice,config_num)

    [A_row, A_col] = size(A);
    Matrix_B = zeros(A_row, 1);

    if multi_choice == 4
        Matrix_Z = ECALE_matrix_generate_v2(config_num, 1);
    end

    for row = 1 : A_row
       for col = 1 : A_col
           if multi_choice == 1
               Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_MBM_t(A(row,col), s(col),8, 8);
           elseif multi_choice == 2
               Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_Optimized(A(row,col), s(col),8);
           elseif multi_choice == 3
               Matrix_B(row) = Matrix_B(row) + fn_MitchellMul_REALM8x8_t(A(row,col), s(col),8, 8);
           elseif multi_choice == 4
               Matrix_B(row) = Matrix_B(row) + Matrix_Z(A(row,col), s(col));
           end
       end
    end
    Matrix_B = mod(Matrix_B,q);
end

