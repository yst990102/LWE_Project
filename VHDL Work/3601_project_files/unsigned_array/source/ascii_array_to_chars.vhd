library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.configuration_set.all;

entity ascii_array_to_chars is
    Port ( 
        clk                   : in std_logic;
        ascii_array_in        : in ascii_array;
        
        decode_chars          : out string(1 to 4);
        sig_result_release    : out std_logic
    );
end ascii_array_to_chars;

architecture Behavioral of ascii_array_to_chars is

    component ascii_to_char is
        Port (
            ascii_val   : in integer;
            char        : out character
        );
    end component;
    
    signal ascii_val_in : integer := 0;
    signal char_out     : character;

begin
    ascii_to_char_process : ascii_to_char
    port map(
        ascii_val => ascii_val_in,
        char => char_out
    );

    asciis_to_string : process
        variable ascii_val : integer := 0;
    begin
        for i in ascii_array'range loop
            ascii_val_in <= to_integer(ascii_array(i));
            decode_chars(i) <= char_out; 
        end loop;
        sig_result_release <= '1';
        wait;
    end process;
    
end Behavioral;

