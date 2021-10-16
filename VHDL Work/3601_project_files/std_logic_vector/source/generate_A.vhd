library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_A is
    port (
        clk           : in std_logic;
        q             : in integer;
        store_row     : out integer;
        store_col     : out integer;
        store_ele     : out integer
    );
end generate_A;

architecture Behavioral of generate_A is
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
        generic map (data_width => 8 )
        port map(
            seed => 250,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    random_matrix_A : 
    process
    begin
        for row in matrixA_1'range(1) loop
            for col in matrixA_1'range(2) loop
                    store_row <= row;
                    store_col <= col;
                    store_ele <= random_result mod(q - 0);
--                wait for 20ps;
                wait until clk'event and clk = '0';
            end loop;
        end loop;
        wait;
    end process;
    
    
end Behavioral;
