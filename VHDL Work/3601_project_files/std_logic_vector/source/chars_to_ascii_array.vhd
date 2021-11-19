library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity chars_to_ascii_array is
    Port ( 
        clk                 : in std_logic;
        encode_chars        : in string(1 to string_length);
        reset               : in std_logic;

        ascii_array_out     : out ascii_array;
        sig_chars_loaded    : out std_logic
    );
end chars_to_ascii_array;

architecture Behavioral of chars_to_ascii_array is
    signal ascii_array : ascii_array := (others=>(others=>'0'));
    signal is_chars_loaded : std_logic := '0';
begin
    string_to_asciis : process
        variable i : integer := 1;
    begin
        if i < (string_length + 1) then
            ascii_array(i) <= conv_std_logic_vector(integer(character'pos(encode_chars(i))), ascii_length);
            wait until clk'event and clk = '0';
            i := i + 1;
        else
            if reset = '1' then
                i := 1;
                is_chars_loaded <= '0';
            else
                is_chars_loaded <= '1';
            end if;
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    ascii_array_out <= ascii_array;
    sig_chars_loaded <= is_chars_loaded;

end Behavioral;
