library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.configuration_set.all;

entity generate_A_by_file_TB is
end generate_A_by_file_TB;

architecture Behavioral of generate_A_by_file_TB is
    component generate_A_by_file is
        port(
            clk : in std_logic;
            txt_input : in std_logic;

            A_row : out integer;
            A_out : out RowA_1;
            file_end : out std_logic
        );
    end component;

    constant clk_period : time := 20ps;
    signal clk : std_logic := '0';
    
    signal sig_A_row : integer := 0;
    signal sig_A_out : RowA_1 := (others => 0);
    signal sig_file_end : std_logic := '0';
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
        txt_input => '1',

        A_row => sig_A_row,
        A_out => sig_A_out,
        file_end => sig_file_end
    );

end Behavioral;
