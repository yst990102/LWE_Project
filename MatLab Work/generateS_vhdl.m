fileID = fopen('../VHDL Work/3601_project_files/std_logic_vector/source/Private_key_S.txt','w');
[s_row, ~] = size(s);
for row = 1:s_row
    if s(row) < 10
        fprintf(fileID,"  %d", s(row));
    elseif A(row, col) < 100
        fprintf(fileID," %d", s(row));
    else
        fprintf(fileID,"%d", s(row));
    end
    fprintf(fileID,"\n");
end
fclose(fileID);