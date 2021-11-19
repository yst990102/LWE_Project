library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_s is
    port(
        clk         : in std_logic;
        q           : in integer;
        store_S_row : out integer;
        store_S_ele : out integer
    );
end generate_s;

architecture Behavioral of generate_s is
    component random_generator is
        generic (data_width : natural);
        port(
            seed : in integer;
            reset : in std_logic;
            clk : in std_logic;
            data_out : out integer);
    end component;
    
    signal random_result : integer;
begin
    random_number: random_generator
        generic map (data_width => 7 )
        port map(
            seed => 230,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    process
    begin
        for row in matrixS_1'range(1) loop
            store_S_row <= row;
            store_S_ele <= random_result mod (q - 0);
--            wait for 20ps;
            wait until clk'event and clk = '0';
        end loop;
        wait;
    end process;

end Behavioral;
