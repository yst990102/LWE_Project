library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.packages.all;

entity q_generator is
    port(
        config_num : in integer;
        clk : in std_logic;
        q : out integer
        );
    
end q_generator;

architecture Behavioral of q_generator is
    component random_generator is
        generic (data_width : natural);
        port(
            reset : in std_logic;
            clk : in std_logic;
            data_out : out integer);
    end component;

    signal random_result : integer;
    signal control : std_logic := '1';
begin
    random_number: random_generator
        generic map (data_width => 17 )
        port map(
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    with config_num select q <=
        random_result mod (q_max_1 - q_min_1) + q_min_1 when 1,
--        random_result mod (q_max_2 - q_min_2) + q_min_2 when 2,
--        random_result mod (q_max_3 - q_min_3) + q_min_3 when 3,
        0 when others;
end Behavioral;
