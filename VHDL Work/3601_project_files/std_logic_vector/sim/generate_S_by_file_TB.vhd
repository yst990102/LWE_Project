library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.configuration_set.all;

entity generate_S_by_file_TB is
end generate_S_by_file_TB;

architecture Behavioral of generate_S_by_file_TB is
    component generate_S_by_file is
        port(
            clk : in std_logic;
            S_out : out integer;
            file_end : out std_logic
        );
    end component;

    constant clk_period : time := 20ps;
    signal clk : std_logic := '0';
    
    signal sig_S_out : integer := 0;
    signal sig_file_end : std_logic := '0';

begin
    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    generate_S_by_file_TB: generate_S_by_file
    port map(
        clk => clk,
        S_out => sig_S_out,
        file_end => sig_file_end
    );

end Behavioral;
