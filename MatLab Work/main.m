exit_state = "";
while exit_state ~= "e"
    input_config_num = input("Enter config_num (1/2/3):", 's');
    config_num = str2double(input_config_num);
    if ~ismember(config_num,[1 2 3])
        error("incorrect config num, please re-run your program.");
    end
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
    
    bits_for_char = 8;
    input_string = input("Enter a string (no length limit):", 's');
    binary_string = StringToBinaryArray(string(input_string), bits_for_char);

    % generate Matrix A, Matrix E, key s, prime q
    [q,A,e,s] = generator(config_num);
    
    if fn_multiplier_choice == 4
        fprintf("ECALE need to preset logdeltas & expdeltas, may need some time...");
        [logdeltas, expdeltas,k] = fn_ECALEMul_preset(q);
    end
    
    % generate Matrix B
    if multiplier_choice == 1
        B = B_accurate_multiplier(A,s,e,q);         % --- accurate multiplier
    elseif multiplier_choice == 2
        B = B_approximate_multiplier(A,s,q,fn_multiplier_choice,logdeltas, expdeltas,k);      % --- approximate multiplier
    end
    
    [char_num, char_length] = size(binary_string);

    DecryptResult = zeros(char_num, char_length);
    for j = 1:char_num
        % Encryption part
        [uv_cell,pair_nums] = EncryptCharToUV(binary_string(j,:),B,A,q);

        % Decryption part
        DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
    end

    fprintf("\nHere is your Decrypted Ascii Array:\n");
    disp(DecryptResult);

    decoded_string = BinaryArrayToString(DecryptResult);
    fprintf("\nHere is your Decrypted String: %s\n", decoded_string);

    if decoded_string == input_string
        fprintf("\n==========================================");
        fprintf("\nCongratulation! You have correct result!\n");
        fprintf("==========================================\n");
    else
        fprintf("\n==========================================");
        fprintf("\nSorry! You have incorrect result!\n");
        fprintf("==========================================\n");
    end

    exit_state = input("\n\nRe-run or Exit?\ne - exit\nr - re_run\n", 's');
    while exit_state ~= "e" && exit_state ~= "r"
        config_num = 0;multiplier_choice = 0;fn_multiplier_choice = 0;
        exit_state = input("\nPlease type 'e' or 'r'\ne - exit\nr - re_run\n", 's');
    end
end