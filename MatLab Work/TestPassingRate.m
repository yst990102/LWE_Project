input_multiplier = input("Enter multiplier choice (1 - accurate, 2 - approximate):", 's');
multiplier_choice = str2double(input_multiplier);

if multiplier_choice == 2
    fn_multiplier = input("Enter approximate-multi choice (1 - MBM, 2 - Optimized MBM, 3 - REALM8x8, 4 - ECALE):", 's');
    fn_multiplier_choice = str2double(fn_multiplier);

    if ~ismember(fn_multiplier_choice,[1 2 3 4])
        error("incorrect fn_multiplier_choice, please re-run your program.");
    end
elseif multiplier_choice ~= 1
    error("incorrect multiplier choice, please re-run your program.");
end

test_nums_input = input("Enter test cases:", 's');
test_nums = str2double(test_nums_input);
if test_nums < 0
    error("incorrect test nums, please re-run your program.");
end

for config_num = 0:3
    fprintf("-------Testing Configuration %d-------\n", config_num);
    success_count = 0;
    time_encrypt = zeros(1,test_nums);
    time_decrypt = zeros(1,test_nums);
        
    for test_num = 1:test_nums
        % generate matrices
        % generate matrix A, matrix E, private key s, prime numebr q
        [q,A,e,s] = generator(config_num);
        % generate matrix B with multiplier-type
        if multiplier_choice == 1
            B = B_accurate_multiplier(A,s,e,q);         % --- accurate multiplier
        elseif multiplier_choice == 2
            B = B_approximate_multiplier(A,s,q,fn_multiplier_choice);      % --- approximate multiplier
        else
            error("incorrect multiplier choice, please re-run your program.");
        end
    
        % encoded string
        binary_string = StringToBinaryArray("AbcD", 8);

        [char_num, char_length] = size(binary_string);
        % allocate memory for decrypt result
        DecryptResult = zeros(char_num, char_length);
        for j = 1:char_num
            % Encryption part
            tic
            uv_cell = EncryptCharToUV(binary_string(j,:),B,A,q);
            time_encrypt(test_num) = toc;
            % Decryption part
            tic
            DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
            time_decrypt(test_num) = toc;
        end
        
        decoded_string = BinaryArrayToString(DecryptResult);
        if decoded_string == "AbcD"       
            success_count = success_count + 1;
        end
    end

    fprintf("\t---Stats---\n");
    fprintf("\t\tTotal cases: %d\n", test_nums);
    fprintf("\t\tSuccess count: %d\n", success_count);
    fprintf("\t\tSuccess rate: %.2f%%\n",(success_count / test_nums) * 100);
    
    time_total = sum(time_encrypt) + sum(time_decrypt);
    
    fprintf("\t---Total Times---\n");
    fprintf("\t\tOverall: %.2fs\n", time_total);
    fprintf("\t\tEncrypt: %.2fs (%.2f%%)\n", sum(time_encrypt), (sum(time_encrypt) / time_total) * 100);
    fprintf("\t\tDecrypt: %.2fs (%.2f%%)\n", sum(time_decrypt), (sum(time_decrypt) / time_total) * 100);
    
    time_avg = time_total / test_nums;
    
    fprintf("\t---Average Times---\n");
    fprintf("\t\tOverall: %.5fs\n", time_avg);
    fprintf("\t\tEncrypt: %.5fs (%.2f%%)\n", mean(time_encrypt), (mean(time_encrypt) / time_avg) * 100);
    fprintf("\t\tDecrypt: %.5fs (%.2f%%)\n", mean(time_decrypt), (mean(time_decrypt) / time_avg) * 100);
end