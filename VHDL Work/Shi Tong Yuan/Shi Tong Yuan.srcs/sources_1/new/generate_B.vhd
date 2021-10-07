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
        Matrix_B       : out matrixB_1;
        state          : out std_logic
    );
end generate_B;

architecture Behavioral of generate_B is
begin
    process
        variable row_sum : integer := 0;
    begin
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            for i in matrixB_1'range(1) loop
                for j in matrixA_1'range(2) loop
                    row_sum := row_sum + Matrix_A(i,j) * Matrix_S(j, 0) + Matrix_E(j, 0);
                end loop;
            
                Matrix_B(i, 0) <= row_sum mod q;
                wait for 20ps;
            end loop;
            state <= '1';
            wait;
        else
            wait for 20ps;
        end if;
    end process;

end Behavioral;
