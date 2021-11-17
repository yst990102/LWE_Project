library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.configuration_set.all;

entity ReadFileByChar_TB is
end ReadFileByChar_TB;

architecture Behavioral of ReadFileByChar_TB is
    component ReadFileByChar is
    port(
        clk : in std_logic;
        string_out : out string(1 to 60)
    );
    end component;

    constant clk_period : time := 20ps;
    
    signal clk : std_logic := '0';
    signal result_string : string(1 to 60);

begin

    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    FileRead : ReadFileByChar
        port map(
            clk =>  clk,
            string_out => result_string
        );

end Behavioral;
