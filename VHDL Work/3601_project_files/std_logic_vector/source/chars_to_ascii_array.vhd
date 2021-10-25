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
    signal ascii_array : ascii_array := (others=>(others=>'0'));
    signal is_chars_loaded : std_logic := '0';
begin
    string_to_asciis : process
        variable i : integer := 1;
    begin
        if i < 5 then
            ascii_array(i) <= conv_std_logic_vector(integer(character'pos(encode_chars(i))), 8);
            wait until clk'event and clk = '0';
            i := i + 1;
        else
            is_chars_loaded <= '1';
            wait;
        end if;

--        for i in ascii_array'range loop
--            ascii_array(i) <= conv_std_logic_vector(integer(character'pos(encode_chars(i))), 8);
--            wait until clk'event and clk = '0';
--        end loop;
--        is_chars_loaded <= '1';
--        wait;
    end process;
    
    ascii_array_out <= ascii_array;
    sig_chars_loaded <= is_chars_loaded;

end Behavioral;
