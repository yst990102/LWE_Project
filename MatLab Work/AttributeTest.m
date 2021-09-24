% Attribute Testing
%% test 1: 256x4 matrix attribute
[q,A,e,s] = generator(1);
[A_row, A_col] = size(A);
assert(A_row == 256);
assert(A_col == 4);
for i = 1:size(e,1)
    tmp = e(i,:);
    assert(tmp >= -1 && tmp <= 1);
end
assert(q >= 1 && q <= 128);
assert(isprime(q), 'q is not a prime number');

%% test 2: 8192x8 matrix attribute
[q,A,e,s] = generator(2);
[A_row, A_col] = size(A);
assert(A_row == 8192);
assert(A_col == 8);
for i = 1:size(e,1)
    tmp = e(i,:);
    assert(tmp >= -4 && tmp <= 4);
end
assert(q >= 2048 && q <= 8192);
assert(isprime(q), 'q is not a prime number');

%% test 3: 32768x16 matrix attribute
[q,A,e,s] = generator(3);
[A_row, A_col] = size(A);
assert(A_row == 32768);
assert(A_col == 16);
for i = 1:size(e,1)
    tmp = e(i,:);
    assert(tmp >= -16 && tmp <= 16);
end
assert(q >= 16384 && q <= 65535);
assert(isprime(q), 'q is not a prime number');