[q,A,e,s] = generator(0);

[A_row, A_col] = size(A);
B = mod(A*s +e, q);

bits_for_char = 8;

input_string = input("Enter a Msg:", 's');
binary_string = StringToBinary(input_string, bits_for_char)

[char_num, char_length] = size(binary_string);

DecryptResult = zeros(char_num, char_length);
for j = 1:char_num
    uv_cell = EncryptCharToUV(binary_string(j,:),B,A,q);
    
    DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
end

disp(DecryptResult);