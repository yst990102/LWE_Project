function [uv_cells, pair_nums] = EncryptCharToUV(bits,B,A,q)
    [~, bit_nums] = size(bits);  % get size of msg
    uv_cells = cell(1,bit_nums);    % pre-allocate memory
    
    [A_rows, ~] = size(A);   % get n
    pairs = round(A_rows / 4);  % need n/4 pairs
        
    for i = 1:bit_nums
        pair_nums = randperm(A_rows, pairs);    % get random pairs
%         pair_nums = [8 5];
        
        A_sample = A(pair_nums, :);
        B_sample = B(pair_nums, :);

        u = mod(sum(A_sample),q);
    
        if bits(i) == '1'
            v = mod(sum(B_sample) - round(q/2),q);
        elseif bits(i) == '0'
            v = mod(sum(B_sample),q);
        end
        
        uv_cells{i} = {u,v};
    end
end
