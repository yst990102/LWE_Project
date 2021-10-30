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
        % B = mod(A*s +e, q);

        bits_for_char = 8;

%         As = zeros([A_row, 1]);
%         for r = 1:A_row
%             for c = 1:A_col
%                 [Result, charA,charB ] = fn_MitchellMul_Optimized(A(r,c), s(c), 8);
%                 As(c) = As(c) + Result;
%             end
%         end

%         B = mod(As, q);

        M = MatrixMul_UnsignedInt16_ApproxMuls(A,s);

        B = mod(M, q);

        binary_string = StringToBinary("A", 8);
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
    
end