fileID = fopen('../VHDL Work/3601_project_files/std_logic_vector/source/Matrix_A.txt','w');
[A_row, A_col] = size(A);
for row = 1:A_row
    for col = 1 : A_col
        if A(row, col) < 10
            fprintf(fileID,"  %d", A(row,col));
        elseif A(row, col) < 100
            fprintf(fileID," %d", A(row, col));
        else
            fprintf(fileID,"%d", A(row, col));
        end
        if col < 4
            fprintf(fileID," ");
        end
    end
    fprintf(fileID,"\n");
end
fclose(fileID);