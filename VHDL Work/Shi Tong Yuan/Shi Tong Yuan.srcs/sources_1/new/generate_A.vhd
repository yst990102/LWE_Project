library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.packages.all;

entity generate_A is
    port (
        clk     : in std_logic;
        q             : in integer;
        Matrix_A      : out matrixA_1;
        state : out std_logic
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
        generic map (data_width => 17 )
        port map(
            seed => 121070,
            reset => '1',
            clk => clk,
            data_out => random_result
        );

    random_matrix_A : 
    process
    begin
        for row in matrixA_1'range(1) loop
            for col in matrixA_1'range(2) loop
                Matrix_A(row,col) <= random_result mod(q - 0);
                wait for 20ps;
            end loop;
        end loop;
        state <= '1';
        wait;
    end process;
    
    
end Behavioral;
