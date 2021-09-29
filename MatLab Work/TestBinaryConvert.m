% BinaryConvertTesting
[q,A,e,s] = generator(0);
[A_row, A_col] = size(A);
B = zeros(A_row,1);
for i = 1: A_row
    B(i,1) = A(i,:)*s;
end
B = mod(B + e, q);

%% Test 1: string_to_binary_character
binary_string = StringToBinary("AbcD", 8);
assert(char(bin2dec(binary_string(1,:)))=='A')
assert(char(bin2dec(binary_string(2,:)))=='b')
assert(char(bin2dec(binary_string(3,:)))=='c')
assert(char(bin2dec(binary_string(4,:)))=='D')

%% Test 2: string_to_binary_number
binary_string = StringToBinary("1234", 8);
assert(char(bin2dec(binary_string(1,:)))=='1')
assert(char(bin2dec(binary_string(2,:)))=='2')
assert(char(bin2dec(binary_string(3,:)))=='3')
assert(char(bin2dec(binary_string(4,:)))=='4')

%% Test 3: string_to_binary_symbol
binary_string = StringToBinary("@#$%", 8);
assert(char(bin2dec(binary_string(1,:)))=='@')
assert(char(bin2dec(binary_string(2,:)))=='#')
assert(char(bin2dec(binary_string(3,:)))=='$')
assert(char(bin2dec(binary_string(4,:)))=='%')

%% More about throw exceptions