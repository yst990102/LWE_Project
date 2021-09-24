test_nums = 1000;

for config_num = 0:3
    fprintf("-------Testing configuration %d------- \n", config_num);
    success_count = 0;
    for test_num = 1:test_nums
        [q,A,e,s] = generator(config_num);

        [A_row, A_col] = size(A);
        B = mod(A*s +e, q);

        bits_for_char = 8;

        binary_string = StringToBinary('AbcD', 8);
        uv_cells = EncryptCharToUV(binary_string,B,A,q);

        [char_num, char_length] = size(binary_string);
        
        DecryptResult = zeros(char_num, char_length);
        for j = 1:char_num
            uv_cell = EncryptCharToUV(binary_string(j,:),B,A,q);

            DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
        end

        success_count = success_count + CheckInputOutputMatch(binary_string, DecryptResult);
    end

    fprintf("Total test cases: %d, success cases: %d, success rate: %.2f%%. \n",test_nums, success_count, (success_count / test_nums) * 100 );
end