[q,A,e,s] = generator(0);

[A_row, A_col] = size(A);
B = zeros(A_row,1);
for i = 1: A_row
    B(i,1) = A(i,:)*s;
end

B = mod(B + e, q);

input_string = input("Enter a Msg:", 's');
binary_string = StringToBinary(input_string, 8);

[word_num, word_size] = size(binary_string);
for j = 1:word_num
    cur_string = binary_string(j,:);
    uv_cell = EncryptMsgToUVs(cur_string,B,A,q);
    disp(uv_cell);
    
    DecryptResult = DecryptUVToMsg(uv_cell,q,s);
    disp(DecryptResult);
end