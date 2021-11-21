library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_A is
    port (
        clk           : in std_logic;
        q             : in integer;
        txt_input     : in std_logic;

        store_A_row     : out integer;
        store_A_ele     : out RowA_1
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
    signal ele_stored : RowA_1 := (others => 0);
    signal random_result : RowA_1;
    --signal seeds      : RowA_1;
begin
    --seeds <= (250, 78, 236, 42);
    --gen_lfsr: for i in 0 to A_col_1-1 generate
    --    random_number1: random_generator
    --        generic map (data_width => 8 )
    --        port map(
    --            seed => seeds(i),
    --            reset => '1',
    --            clk => clk,
    --            data_out => random_result(i)
    --        );
    --end generate gen_lfsr;
    
        random_number0: random_generator
            generic map (data_width => 8 )
            port map(
                seed => 250,
                reset => '1',
                clk => clk,
                data_out => random_result(0)
            );
       random_number1: random_generator
            generic map (data_width => 8 )
            port map(
                seed => 78,
                reset => '1',
                clk => clk,
                data_out => random_result(1)
            );
        random_number2: random_generator
        generic map (data_width => 8 )
        port map(
            seed => 236,
            reset => '1',
            clk => clk,
            data_out => random_result(2)
        );
        
        random_number3: random_generator
        generic map (data_width => 8 )
        port map(
            seed => 42,
            reset => '1',
            clk => clk,
            data_out => random_result(3)
        );
        
    random_matrix_A : 
    process
        variable row : integer := 0;
    begin
        if txt_input = '0' then
            if row < A_row_1 then
                row_stored <= row;
                ele_stored(0) <= random_result(0) mod(q);
                ele_stored(1) <= random_result(1) mod(q);
                ele_stored(2) <= random_result(2) mod(q);
                ele_stored(3) <= random_result(3) mod(q);
                -- done for debugging. Could also be done like this.
                --Gen_ele: for i in 0 to A_col_1-1 loop
                --    ele_stored(i) <= random_result(i) mod(q);
                --end loop;
                wait until clk'event and clk = '0';
                row := row + 1;
            else
                wait;
            end if;
        else
            wait;
        end if;
    end process;
    
    store_A_row <= row_stored;
    store_A_ele(0) <= ele_stored(0);
    store_A_ele(1) <= ele_stored(1);
    store_A_ele(2) <= ele_stored(2);
    store_A_ele(3) <= ele_stored(3);
    
end Behavioral;
