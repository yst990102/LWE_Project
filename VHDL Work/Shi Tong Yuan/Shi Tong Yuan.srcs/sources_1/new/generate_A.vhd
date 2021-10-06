library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.MATH_REAL.ALL;
use work.packages.all;

entity generate_A is
    port (
        generate_A    : in  std_logic ;
        q             : in integer;
        Matrix_A      : out matrixA_1
    );
end generate_A;

architecture Behavioral of generate_A is
    signal output_matrix : matrixA_1;
begin        
    random_matrix_A : 
    process
    begin
        if generate_A = '1' then
            output_matrix <= (others => (others => 0));
        end if;
        
        for row in matrixA_1'range(1) loop
            for col in matrixA_1'range(2) loop
                output_matrix(row, col) <= q;
            end loop;
        end loop;
    end process;
    
    Matrix_A <= output_matrix;
end Behavioral;
