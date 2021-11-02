library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.configuration_set.all;

entity Processor_TB is
end Processor_TB;

architecture Behavioral of Processor_TB is
    component Processor is
        port (
            encode_string   : in string(1 to string_length);
            clk             : in std_logic;
            sig_reset       : in std_logic;
            txt_input       : in std_logic;
            multi_type      : in integer;
    
            result          : out string(1 to string_length)
        );
    end component;
    
    constant clk_period : time := 20ps;
    
    signal clk : std_logic := '0';
    signal final_result : string(1 to string_length) := (others => NUL);

    signal test_string : string(1 to string_length) := (others => NUL);
    signal reset : std_logic := '0';
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
            txt_input => '0',
            multi_type => 1,        -- 1:accurate, 2:MBM, 3:Mit, 4:REALM
            result => final_result
        );

    main_testing : process
    begin
        wait for 100 ns;
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for 2 sec;
    end process;

end Behavioral;
