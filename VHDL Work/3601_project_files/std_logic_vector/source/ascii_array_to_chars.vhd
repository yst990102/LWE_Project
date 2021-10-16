library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Std_Logic_Arith.ALL;
use work.configuration_set.all;

entity ascii_array_to_chars is
    Port ( 
        clk                   : in std_logic;
        sig_is_dec_generated  : in std_logic;
        ascii_array_in        : in ascii_array;
        
        decode_chars          : out string(1 to 4);
        sig_result_release    : out std_logic
    );
end ascii_array_to_chars;

architecture Behavioral of ascii_array_to_chars is
    type ascii_int_list is array (65 to 122) of integer; 
    type ascii_char_list is array (65 to 122) of character; 
    
    signal ascii_int_list01 : ascii_int_list := (
        65,66,67,68,69,70,
        71,72,73,74,75,76,77,78,79,80,
        81,82,83,84,85,86,87,88,89,90,
        91,92,93,94,95,96,97,98,99,100,
        101,102,103,104,105,106,107,108,109,110,
        111,112,113,114,115,116,117,118,119,120,
        121,122);

    signal ascii_char_list01: ascii_char_list := (
        'A','B','C','D','E','F',
        'G','H','I','J','K','L','M','N','O','P',
        'Q','R','S','T','U','V','W','X','Y','Z',
        '[','\',']','^','_','`','a','b','c','d',
        'e','f','g','h','i','j','k','l','m','n',
        'o','p','q','r','s','t','u','v','w','x',
        'y','z');

begin

    asciis_to_string : process
        variable i : integer := 1;
        variable ascii_val : integer := 0;
        variable char_out : character;
    begin
        if sig_is_dec_generated = '1' then
            ascii_val := conv_integer(unsigned(ascii_array_in(i)));
            if ascii_val >= 65 and ascii_val <= 122 then
                decode_chars(i) <= ascii_char_list01(ascii_val);
            else
                decode_chars(i) <= NUL;
            end if;
            i := i + 1;
                
            if i = 5 then
                sig_result_release <= '1';
                wait;
            end if;
            wait until clk'event and clk = '0';
        else
            wait until clk'event and clk = '0';
        end if;
        
    end process;
    
end Behavioral;

