library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.math_real.all;
use work.packages.all;

entity generate_s is
    port(
        config_num : in integer;
        q : in integer;
        s : out matrixS_1
    );
end generate_s;

architecture Behavioral of generate_s is
begin
--    s(0, 0) <= (q);
--    s(1, 0) <= (q);
--    s(2, 0) <= (q);
--    s(3, 0) <= (q);

    process
        variable r : real;
        variable seed1, seed2 : integer := 9;
    begin
        wait for 60ps; 
        for i in 0 to A_col_1-1 loop
            uniform(seed1, seed2, r);
            s(i, 0) <= integer(round(r * real(q - 0 + 1) + real(0) - 0.5));
        end loop;
        wait;
    end process;

end Behavioral;
