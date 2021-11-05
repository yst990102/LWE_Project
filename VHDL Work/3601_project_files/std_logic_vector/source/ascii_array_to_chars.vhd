library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Std_Logic_Arith.ALL;
use work.configuration_set.all;

entity ascii_array_to_chars is
    Port ( 
        clk                   : in std_logic;
        sig_is_dec_generated  : in std_logic;
        ascii_array_in        : in ascii_array;
        
        decode_string         : out string(1 to string_length);
        sig_result_release    : out std_logic
    );
end ascii_array_to_chars;

architecture Behavioral of ascii_array_to_chars is
    signal ascii_list : string(32 to 126) := " !""#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
    
    signal final_string : string(1 to string_length) := (others => NUL);
    signal is_result_released : std_logic := '0';
begin

    asciis_to_string : process
        variable i : integer := 1;
        variable ascii_val : integer := 0;
    begin
        if sig_is_dec_generated = '1' then
            if i < (string_length + 1) then
                ascii_val := conv_integer(unsigned(ascii_array_in(i)));
                if ascii_val >= 32 and ascii_val <= 126 then
                    final_string(i) <= ascii_list(ascii_val);
                end if;
                i := i + 1;
            else
                is_result_released <= '1';
                wait;
            end if;
            wait until clk'event and clk = '0';
        else
            wait until clk'event and clk = '0';
        end if;
        
    end process;
    
    decode_string <= final_string;
    sig_result_release <= is_result_released;
    
end Behavioral;

