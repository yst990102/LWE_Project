exit_state = "";
while exit_state ~= "e"
    input_config_num = input("Enter config_num (1/2/3):", 's');
    config_num = str2double(input_config_num);

    [q,A,e,s] = generator(config_num);

    [A_row, A_col] = size(A);

    input_multiplier = input("Enter multiplier choice (1 - accurate, 2 - approximate):", 's');
    multiplier_choice = str2double(input_multiplier);

    if multiplier_choice == 2
        fn_multiplier = input("Enter approximate-multi choice (1 - MBM, 2 - Optimized MBM, 3 - REALM8x8):", 's');
        fn_multiplier_choice = str2double(fn_multiplier);
    end

    if multiplier_choice == 1
        B = B_accurate_multiplier(A,s,e,q);         % --- accurate multiplier
    elseif multiplier_choice == 2
        B = B_approximate_multiplier(A,s,q,fn_multiplier_choice);      % --- approximate multiplier
    else
        error("incorrect multiplier choice, please re-run your program.");
    end

    bits_for_char = 8;

    input_string = input("Enter a string (no length limit):", 's');
    binary_string = StringToBinary(string(input_string), bits_for_char);

    [char_num, char_length] = size(binary_string);

    DecryptResult = zeros(char_num, char_length);
    for j = 1:char_num
        [uv_cell,pair_nums] = EncryptCharToUV(binary_string(j,:),B,A,q);

        DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
    end

    fprintf("\nHere is your Decrypted Ascii Array:\n");
    disp(DecryptResult);

    [dec_row, dec_col] = size(DecryptResult);
    decoded_string = "";
    for i = 1 : dec_row
        bin_vector = num2str(DecryptResult(i,:));
        bin_vector(isspace(bin_vector)) = '';
        decoded_char = char(bin2dec(bin_vector));
        decoded_string = append(decoded_string, decoded_char);
        % fprintf("decoded_char %d == %c\n", i, decoded_char);
    end
    
    fprintf("\nHere is your final decoded string : %s\n", decoded_string);

    if decoded_string == input_string
        fprintf("\n==========================================");
        fprintf("\nCongratulation! You have correct result!\n");
        fprintf("==========================================\n");
    else
        fprintf("\n==========================================");
        fprintf("\nSorry! You have incorrect result!\n");
        fprintf("==========================================\n");
    end

    exit_state = input("\n\nRe-run or Exit (e - exit, r - re_run)\n", 's');
end