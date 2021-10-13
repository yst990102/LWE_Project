library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_e is
    port(
        clk     : in std_logic;
        q       : in integer;
        store_E_row : out integer;
        store_E_ele : out integer
    );
end generate_e;

architecture Behavioral of generate_e is
    component random_generator is
        generic (data_width : natural);
        port(
            seed : integer;
            reset : in std_logic;
            clk : in std_logic;
            data_out : out integer);
    end component;
    
    signal random_result : integer;
begin
    random_number: random_generator
        generic map (data_width => 7 )
        port map(
            seed => 210,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    process
    begin
        for row in matrixE_1'range(1) loop
            store_E_row <= row;
            store_E_ele <= random_result mod (e_max_1 - e_min_1) + e_min_1;
--            wait for 20ps;
            wait until clk'event and clk = '0';
        end loop;
        wait;
    end process;
    

end Behavioral;
