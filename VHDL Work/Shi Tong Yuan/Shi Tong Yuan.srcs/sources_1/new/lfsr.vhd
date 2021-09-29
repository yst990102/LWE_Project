
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity lfsr is
    generic (data_width : natural := 8 );
end lfsr;

architecture rtl of lfsr is
    signal feedback : std_logic;
    signal lfsr_reg : UNSIGNED(data_width - 1 downto 0);
    
    
    signal data_out : UNSIGNED(data_width - 1 downto 0);
    signal reset : std_logic ;
    signal clk : std_logic := '0';      
    constant clk_period : time := 50ps;
begin
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    reset <= '1';

    feedback <= lfsr_reg(7) xor lfsr_reg(0);
    latch_it : process(clk,reset)
    begin
        if (reset = '1') then
            lfsr_reg <= (others => '0');
        elsif (clk = '1' and clk'event) then  
            lfsr_reg <= lfsr_reg(lfsr_reg'high - 1 downto 0) & feedback ;  
        end if;  
    end process ;  
    data_out <= lfsr_reg ;  
end RTL;