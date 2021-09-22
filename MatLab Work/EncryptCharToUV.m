function [uv_cells] = EncryptCharToUV(char,B,A,q)
    [~, size_char] = size(char);  % get size of msg
    uv_cells = cell(1,size_char);    % pre-allocate memory
    
    [A_rows, ~] = size(A);   % get n
    pairs = round(A_rows / 4);  % need n/4 pairs
        
    for i = 1:size_char
        pair_nums = randperm(A_rows, pairs);    % get random pairs
%         pair_nums = [8 5];
        
        A_sample = A(pair_nums, :);
        B_sample = B(pair_nums, :);

        u = mod(sum(A_sample),q);
    
        if char(i) == '1'
            v = mod(sum(B_sample) - round(q/2),q);
        else % char(i) == 0
            v = mod(sum(B_sample),q);
        end
        
        uv_cells{i} = {u,v};
    end
end
