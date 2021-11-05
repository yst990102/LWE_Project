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
        A_row         : in integer;
        A_col         : in integer;

        RowA_in        : in RowA_3;
        Matrix_S       : in matrixS_3;
        RowE_in        : in integer;
        
        store_B_row    : out integer;
        store_B_ele    : out integer
        
    );
end generate_B;

architecture Behavioral of generate_B is

    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
begin
    process
        variable row_sum : integer := 0;
        variable i, j : integer := 0;
        variable skip_wait : std_logic := '0';
    begin        
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            if i < A_row then
                if skip_wait = '0' then
                    wait until clk'event and clk = '1';
                    row_sum := 0;
                    skip_wait := '1';
                end if;
            
                if j < A_col then
                    row_sum := row_sum + RowA_in(j) * Matrix_S(j);
                    j := j + 1;
                else
                    row_stored <= i;
                    ele_stored <= (row_sum  + RowE_in)mod q;
                    j := 0;
                    i := i + 1;
                    skip_wait := '0';
                end if;
            else
                wait;
            end if;
        else
            wait until clk'event and clk = '0';
        end if;    
    end process;
    
    store_B_row <= row_stored;
    store_B_ele <= ele_stored;

end Behavioral;
