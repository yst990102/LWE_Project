library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_e is
    port(
        is_q_generated : in std_logic;
        clk           : in std_logic;
        q             : in integer;
        config_num    : in integer;
        A_row         : in integer;
        
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
    signal random_result : integer := 0;
begin
    random_number: random_generator
        generic map (data_width => 20 )
        port map(
            seed => 210,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    process
        variable row : integer := 0;
    begin
        if is_q_generated = '1' then            
            if row < A_row then
                row_stored <= row;
                
                if config_num =  1 then
                    ele_stored <= random_result mod (e_max_1 - e_min_1 + 1) + e_min_1;
                elsif config_num = 2 then
                    ele_stored <= random_result mod (e_max_2 - e_min_2 + 1) + e_min_2;
                else
                    ele_stored <= random_result mod (e_max_3 - e_min_3 + 1) + e_min_3;
                end if;
                
                wait until clk'event and clk = '0';
                row := row + 1;
            else
                wait;
            end if;
        else
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    store_E_row <= row_stored;
    store_E_ele <= ele_stored;

end Behavioral;
