library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.MATH_REAL.ALL;
use work.packages.all;

entity generate_A is
    port (
        clk      : in  std_logic ;
        reset    : in  std_logic ;
        q : in integer;
        Matrix_A : out matrixA_1
    );
end generate_A;

architecture Behavioral of generate_A is
    signal control : std_logic := '1';
begin        
    random_matrix_A : 
    process
        variable output : matrixA_1;
    begin
        if (reset = '0') and control = '1' then
            output := (others => (others => 0));
            control <= '0';
        elsif (clk = '1' and clk'event) then
            output := (others => (others => q));
        end if;
        
        Matrix_A <= output;
    end process;
end Behavioral;
