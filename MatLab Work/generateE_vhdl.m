fileID = fopen('../VHDL Work/3601_project_files/std_logic_vector/source/Matrix_E.txt','w');
[e_row, ~] = size(e);
for row = 1:e_row
    if e(row) == -1
        fprintf(fileID,"%d", e(row));
    else
        fprintf(fileID," %d", e(row));
    end
    fprintf(fileID,"\n");
end
fclose(fileID);