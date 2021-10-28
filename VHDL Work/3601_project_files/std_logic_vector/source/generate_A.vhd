library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_A is
    port (
        clk           : in std_logic;
        q             : in integer;
        
        store_A_row     : out integer;
        store_A_col     : out integer;
        store_A_ele     : out integer
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

    signal row_stored : integer := 0;
    signal col_stored : integer := 0;
    signal ele_stored : integer := 0;    
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
        variable row : integer := 0;
        variable col : integer := 0;
    begin
        if row < A_row_1 then
            if col < A_col_1 then
                row_stored <= row;
                col_stored <= col;
                ele_stored <= random_result mod(q - 0);
                wait until clk'event and clk = '0';
                col := col + 1;
            else
                col := 0;
                row := row + 1;
            end if;
        else
            wait;
        end if;
    end process;
    
    store_A_row <= row_stored;
    store_A_col <= col_stored;
    store_A_ele <= ele_stored;
    
end Behavioral;
