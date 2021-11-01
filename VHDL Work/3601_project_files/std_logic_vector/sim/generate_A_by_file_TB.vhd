library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.configuration_set.all;

entity generate_A_by_file_TB is
end generate_A_by_file_TB;

architecture Behavioral of generate_A_by_file_TB is
    component text_file_io is
        port(
            clk : in std_logic;
            rowA_out : out RowA_1
        );
    end component;

    constant clk_period : time := 20ps;
    signal clk : std_logic := '0';
    
    signal result : RowA_1 := (others => 0);

begin
    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    generate_A_by_file_TB: generate_A_by_file
    port map(
        clk => clk,
        rowA_out => result
    );

end Behavioral;
