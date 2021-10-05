test_nums = 1000;

for config_num = 0:3
    fprintf("-------Testing Configuration %d-------\n", config_num);
    success_count = 0;
    time_encrypt = zeros(1,test_nums);
    time_decrypt = zeros(1,test_nums);
    
    for test_num = 1:test_nums
        tic
        [q,A,e,s] = generator(config_num);

        [A_row, A_col] = size(A);
        B = mod(A*s +e, q);

        bits_for_char = 8;

        binary_string = StringToBinary("AbcD", 8);
        uv_cells = EncryptCharToUV(binary_string,B,A,q);
        time_encrypt(test_num) = toc;
        tic

        [char_num, char_length] = size(binary_string);
        
        DecryptResult = zeros(char_num, char_length);
        for j = 1:char_num
            uv_cell = EncryptCharToUV(binary_string(j,:),B,A,q);

            DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
        end
        
        time_decrypt(test_num) = toc;
        success_count = success_count + CheckInputOutputMatch(binary_string, DecryptResult);
    end

    fprintf("\t---Stats---\n");
    fprintf("\t\tTotal cases: %d\n", test_nums);
    fprintf("\t\tSuccess count: %d\n", success_count);
    fprintf("\t\tSuccess rate: %.2f%%\n",(success_count / test_nums) * 100);
    
    time_total = sum(time_encrypt) + sum(time_decrypt);
    time_avg = time_total / test_nums;
    
    fprintf("\t---Total Times---\n");
    fprintf("\t\tOverall: %.2fs\n", time_total);
    fprintf("\t\tEncrypt: %.2fs (%.2f%%)\n", sum(time_encrypt), (sum(time_encrypt) / time_total) * 100);
    fprintf("\t\tDecrypt: %.2fs (%.2f%%)\n", sum(time_decrypt), (sum(time_decrypt) / time_total) * 100);
    
    fprintf("\t---Average Times---\n");
    fprintf("\t\tOverall: %.5fs\n", time_avg);
    fprintf("\t\tEncrypt: %.5fs (%.2f%%)\n", mean(time_encrypt), (mean(time_encrypt) / time_avg) * 100);
    fprintf("\t\tDecrypt: %.5fs (%.2f%%)\n", mean(time_decrypt), (mean(time_decrypt) / time_avg) * 100);
end