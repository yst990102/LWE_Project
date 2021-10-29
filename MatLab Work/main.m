[q,A,e,s] = generator(0);

[A_row, A_col] = size(A);
% B = mod(A*s +e, q);
bits_for_char = 8;


As = zeros([A_row, 1]);
for r = 1:A_row
    for c = 1:A_col
        [Result, charA,charB ] = fn_MitchellMul_Optimized(A(r,c), s(c), 8);
        As(c) = As(c) + Result;
    end
end

B = mod(As, q);

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