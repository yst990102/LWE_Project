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
    
    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
    signal random_result : integer;
begin
    random_number: random_generator
        generic map (data_width => 8 )
        port map(
            seed => 230,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    process
        variable col : integer := 0;
    begin
        if col < A_col_1 then
            row_stored <= col;
            ele_stored <= random_result mod (q - 0);
            wait until clk'event and clk = '0';
            col := col + 1;
        else
            wait;
        end if;
    end process;
    
    store_S_row <= row_stored;
    store_S_ele <= ele_stored;
end Behavioral;
