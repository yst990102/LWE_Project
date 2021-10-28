[q,A,e,s] = generator(2);

[A_row, A_col] = size(A);
% B = B_normal_multiplier(A,s,e,q);
B = B_approximate_multiplier(A,s,q);

bits_for_char = 8;

input_string = input("Enter a string:", 's');
binary_string = StringToBinary(string(input_string), bits_for_char);

[char_num, char_length] = size(binary_string);

DecryptResult = zeros(char_num, char_length);
for j = 1:char_num
    [uv_cell,pair_nums] = EncryptCharToUV(binary_string(j,:),B,A,q);
    
    DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
end

disp(DecryptResult);
disp(CheckInputOutputMatch(binary_string, DecryptResult));