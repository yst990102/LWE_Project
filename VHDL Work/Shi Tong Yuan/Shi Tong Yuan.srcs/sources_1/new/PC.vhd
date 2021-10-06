library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    port (
          clk : out std_logic);
end PC;

architecture Behavioral of PC is
    constant clk_period : time := 20ps;
begin
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

end Behavioral;
