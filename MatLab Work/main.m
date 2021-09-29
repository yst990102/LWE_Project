[q,A,e,s] = generator(1);

[A_row, A_col] = size(A);
B = mod(A*s +e, q);

bits_for_char = 8;

binary_string = StringToBinary("AbcD", bits_for_char)

[char_num, char_length] = size(binary_string);

DecryptResult = zeros(char_num, char_length);
for j = 1:char_num
    [uv_cell,pair_nums] = EncryptCharToUV(binary_string(j,:),B,A,q);
    
    DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
end

disp(DecryptResult);
disp(CheckInputOutputMatch(binary_string, DecryptResult));