library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_B is
    port(
        is_S_generated : in std_logic;
        is_A_generated : in std_logic;
        is_E_generated : in std_logic;
        clk            : in std_logic;
        q              : in integer;
        RowA_in        : in RowA_1;
        Matrix_S       : in matrixS_1;
        RowE_in        : in integer;
        
        store_B_row    : out integer;
        store_B_ele    : out integer
        
    );
end generate_B;

architecture Behavioral of generate_B is

    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
    signal temp_sum : integer;
begin
    process
        variable row_sum : integer := 0;
    begin
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            for i in matrixB_1'range(1) loop
                wait until clk'event and clk = '1';
                row_sum := 0;
                for j in RowA_1'range(1) loop
                    row_sum := row_sum + RowA_in(j) * Matrix_S(j);
                end loop;
                
                row_stored <= i;
                ele_stored <= (row_sum  + RowE_in)mod q;
            end loop;
            wait;
        else
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    store_B_row <= row_stored;
    store_B_ele <= ele_stored;

end Behavioral;
