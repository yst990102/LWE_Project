[q,A,e,s] = generator(0);

[A_row, A_col] = size(A);
for i = 1: A_row
    B(i,1) = A(i,:)*s;
end

B = mod(B + e, q);

binary_string = StringToBinary('AbcD', 8);
uv_cells = EncryptMsgToUVs(binary_string,B,A,q);

[word_num, word_size] = size(binary_string);
for j = 1:word_num
    cur_string = binary_string(j,:);
    uv_cell = EncryptMsgToUVs(cur_string,B,A,q);
    disp(DecryptUVToMsg(uv_cell,q,s));
end