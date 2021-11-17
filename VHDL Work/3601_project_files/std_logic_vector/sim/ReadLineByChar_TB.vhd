library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.configuration_set.all;

entity ReadLineByChar_TB is
end ReadLineByChar_TB;

architecture Behavioral of ReadLineByChar_TB is
    component ReadLineByChar is
        port(
            clk : in std_logic;
            txt_input : in std_logic;

            char_out : out character;
            file_end : out std_logic
        );
    end component;

    constant clk_period : time := 20ps;
    signal clk : std_logic := '0';
    
    signal sig_char_out : character;
    signal sig_file_end : std_logic := '0';

begin
    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    ReadLineByChar_TB: ReadLineByChar
    port map(
        clk => clk,
        txt_input => '1',

        char_out => sig_char_out,
        file_end => sig_file_end
    );

end Behavioral;
