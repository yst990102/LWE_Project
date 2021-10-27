library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.configuration_set.all;

entity Processor_TB is
end Processor_TB;

architecture Behavioral of Processor_TB is
    component Processor is
        port (
            encode_string : in string(1 to string_length);
            clk : in std_logic := '0';
            sig_reset : in std_logic;
            result : out string(1 to string_length)
        );
    end component;
    
    constant clk_period : time := 20ps;
    
    signal clk : std_logic := '0';
    signal final_result : string(1 to string_length);

    signal test_string : string(1 to string_length);
    signal reset : std_logic;
begin

    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process; 
    
    UUT : Processor
        port map(
            encode_string => "AbcD",
            clk => clk,
            sig_reset => reset,
            result => final_result
        );

    main_testing : process
    begin
        reset <= '1';
        wait for 2 * clk_period;
        reset <= '0';
        wait for 2 sec;
    end process;

end Behavioral;
