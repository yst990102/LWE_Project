library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ascii_to_char is
    Port (
        ascii_val   : in integer;
        char        : out character
    );
end ascii_to_char;

architecture Behavioral of ascii_to_char is

begin
    with ascii_val select
        char <= 'A' when 65,
                'B' when 66,
                'C' when 67,
                'D' when 68,
                'a' when 97,
                'b' when 98,
                'c' when 99,
                'd' when 100,
                '|' when others;
                
end Behavioral;
