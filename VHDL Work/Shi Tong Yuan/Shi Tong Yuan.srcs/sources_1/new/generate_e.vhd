library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.packages.all;

entity generate_e is
    port(
        config_num : in integer;
        q : in integer;
        e : out matrixE_1
    );
end generate_e;

architecture Behavioral of generate_e is
begin
    process
    begin
        for i in 0 to A_row_1-1 loop
            e(i, 0) <= q;
        end loop;
        wait;
    end process;
    

end Behavioral;
