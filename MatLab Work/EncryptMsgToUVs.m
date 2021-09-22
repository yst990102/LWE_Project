function [uv_cells] = EncryptMsgToUVs(Msg,B,A,q)
    [~, size_Msg] = size(Msg);  % get size of msg
    uv_cells = cell(1,size_Msg);    % pre-allocate memory
    
    [A_rows, ~] = size(A);   % get n
    pairs = round(A_rows / 4);  % need n/4 pairs
        
    for i = 1:size_Msg
        pair_nums = randperm(A_rows, pairs);    % get random pairs
        
        A_sample = A(pair_nums, :);
        B_sample = B(pair_nums, :);

        u = mod(sum(A_sample),q);
    
        if Msg(i) == '1'
            v = mod(sum(B_sample) - round(q/2),q);
        else % Msg(i) == 0
            v = mod(sum(B_sample),q);
        end
        
        uv_cells{i} = {u,v};
    end
end
