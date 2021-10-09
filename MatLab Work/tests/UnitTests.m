classdef UnitTests < matlab.unittest.TestCase

%   TestConfuguration
    methods (Test)
        function Config0(testCase)
            [q,A,e,s] = generator(0);
            [A_row, A_col] = size(A);
            testCase.verifyEqual(A_row,8);
            testCase.verifyEqual(A_col,4);
            for i = 1:size(e,1)
                tmp = e(i,:);
                assert(tmp >= -2 && tmp <= 2);
            end
            testCase.verifyEqual(q,79);
            assert(isprime(q), 'q is not a prime number');
        end
        function Config1(testCase)
            [q,A,e,s] = generator(1);
            [A_row, A_col] = size(A);
            testCase.verifyEqual(A_row,256);
            testCase.verifyEqual(A_col,4);    
        end
        
        function Config2(testCase)
            [q,A,e,s] = generator(2);
            [A_row, A_col] = size(A);
            testCase.verifyEqual(A_row,8192);
            testCase.verifyEqual(A_col,8);    
        end
        
        function Config3(testCase)
            [q,A,e,s] = generator(3);
            [A_row, A_col] = size(A);
            testCase.verifyEqual(A_row,32768);
            testCase.verifyEqual(A_col,16);
        end
        
        function ConfigError(testCase)
            testCase.verifyError(@()generator(4), '');
        end
    end

%   Test StringToBinary
    methods (Test)
        function ValidType(testCase)
            input = "ABC";
            act = StringToBinary(input, 8);
            exp = ['01000001';'01000010';'01000011'];
            testCase.verifyEqual(act,exp);
        end

        function NotDouble(testCase)
            input = "ABC";
            testCase.verifyError(@()StringToBinary(input,'String'),'');
        end

        function NotString(testCase)
            input = 123;
            testCase.verifyError(@()StringToBinary(input,8),'');
        end

        function NeitherValidType(testCase)
            input = 123;
            testCase.verifyError(@()StringToBinary(input,'String'),'');
        end
    end

%   Test EncryptnDecrypt
    methods (Test)
        function EncryptandDecrypt(testCase)
            input = " !""#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
            binaryInput = StringToBinary(input, 8);
            [char_num, char_length] = size(binaryInput);
            for i = 0:3
                [q,A,e,s] = generator(i);
                [A_row, A_col] = size(A);
                B = mod(A*s +e, q);

                DecryptResult = zeros(char_num, char_length);
                for j = 1:char_num
                    [uv_cell,pair_nums] = EncryptCharToUV(binaryInput(j,:),B,A,q);

                    DecryptResult(j,:) = DecryptUVToChar(uv_cell,q,s);
                end
                testCase.verifyEqual(CheckInputOutputMatch(binaryInput,DecryptResult), true);
            end
        end
    end
end