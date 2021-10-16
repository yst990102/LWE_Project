library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.configuration_set.all;

entity Processor_TB is
end Processor_TB;

architecture Behavioral of Processor_TB is
    component Processor is
        port (
            encode_string : in string(1 to 4);
            clk : in std_logic := '0';
            result : out string(1 to 4)
        );
    end component;
    
    constant clk_period : time := 20ps;
    
    signal clk : std_logic;
    signal final_result : string(1 to 4);
begin

    clk_generate : process
    begin
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
    end process; 
    
    UUT : Processor
        port map(
            encode_string => "AbcD",
            clk => clk,
            result => final_result
        );


end Behavioral;
