library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_e is
    port(
        clk     : in std_logic;
        q       : in integer;
        txt_input     : in std_logic;

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
    
    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
    signal random_result : integer;
begin
    random_number: random_generator
        generic map (data_width => 8 )
        port map(
            seed => 210,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    process
        variable row : integer := 0;
    begin
        if txt_input = '0' then
            if row < A_row_1 then
                row_stored <= row;
                ele_stored <= random_result mod (e_max_1 - e_min_1 + 1) + e_min_1;
                wait until clk'event and clk = '0';
                row := row + 1;
            else
                wait;
            end if;
        else
            wait;
        end if;
    end process;
    
    store_E_row <= row_stored;
    store_E_ele <= ele_stored;

end Behavioral;
