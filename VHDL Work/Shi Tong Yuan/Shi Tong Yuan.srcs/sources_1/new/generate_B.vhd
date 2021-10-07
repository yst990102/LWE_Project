library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.packages.all;

entity generate_B is
    port(
        is_S_generated : in std_logic;
        is_A_generated : in std_logic;
        is_E_generated : in std_logic;
        clk            : in std_logic;
        q              : in integer;
        Matrix_A       : in matrixA_1;
        Matrix_S       : in matrixS_1;
        Matrix_E       : in matrixE_1;
        
        store_B_row    : out integer;
        store_B_ele    : out integer
        
    );
end generate_B;

architecture Behavioral of generate_B is

    signal temp_sum : integer;
begin
    process
        variable row_sum : integer := 0;
    begin
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            for i in matrixB_1'range(1) loop
                for j in matrixA_1'range(2) loop
                    row_sum := row_sum + Matrix_A(i,j) * Matrix_S(j, 0);
                end loop;
                
                store_B_row <= i;
                store_B_ele <= (row_sum  + Matrix_E(i, 0))mod q;
                wait for 20ps;
                row_sum := 0;
            end loop;
            wait;
        else
            wait for 20ps;
        end if;
    end process;

end Behavioral;
