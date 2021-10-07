library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.math_real.all;
use work.packages.all;

entity generate_A is
    port (
        generate_A    : in  std_logic ;
        q             : in integer;
        Matrix_A      : out matrixA_1
    );
end generate_A;

architecture Behavioral of generate_A is
    function rand_int(min_val, max_val : integer) return integer is
        variable r : real;
        variable seed1, seed2 : integer := 5;
    begin
        uniform(seed1, seed2, r);
        return integer(round(r * real(max_val - min_val + 1) + real(min_val) - 0.5));
    end function;
begin        
    random_matrix_A : 
    process
        variable r : real;
        variable seed1, seed2 : integer := 9;
    begin
        wait for 60ps; 
        for row in matrixA_1'range(1) loop
            for col in matrixA_1'range(2) loop
                uniform(seed1, seed2, r);
                Matrix_A(row, col) <= integer(round(r * real(q - 0 + 1) + real(0) - 0.5));
                seed1 := seed1 + 1;
                seed2 := seed2 + 2;
--                output_matrix(row, col) := rand_int(0, q);
            end loop;
        end loop;
        wait;
    end process;
    
    
end Behavioral;
