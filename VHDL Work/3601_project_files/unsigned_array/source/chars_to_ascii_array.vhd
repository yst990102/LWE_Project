library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity chars_to_ascii_array is
    Port ( 
        clk                 : in std_logic;
        encode_chars        : in string(1 to 4);
        
        ascii_array_out     : out ascii_array;
        sig_chars_loaded    : out std_logic
    );
end chars_to_ascii_array;

architecture Behavioral of chars_to_ascii_array is

begin
    string_to_asciis : process      -- synthesizable now
    begin
        for i in ascii_array'range loop
            ascii_array_out(i) <= conv_unsigned(integer(character'pos(encode_chars(i))), 8);
            wait until clk'event and clk = '0';
        end loop;
        sig_chars_loaded <= '1';
        wait;
    end process;
end Behavioral;
