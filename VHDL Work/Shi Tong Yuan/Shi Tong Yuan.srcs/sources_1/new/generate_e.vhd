library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.math_real.all;
use work.packages.all;

entity generate_e is
    port(
        config_num : in integer;
        q : in integer;
        e : out matrixE_1
    );
end generate_e;

architecture Behavioral of generate_e is
    function rand_int(min_val, max_val : integer) return integer is
        variable r : real;
        variable seed1, seed2 : integer := 5;
    begin
        uniform(seed1, seed2, r);
        return integer(round(r * real(max_val - min_val + 1) + real(min_val) - 0.5));
    end function;
begin
    process
        variable r : real;
        variable seed1, seed2 : integer := 9;
    begin
        wait for 60ps; 
        for i in 0 to A_row_1-1 loop
            uniform(seed1, seed2, r);
            e(i, 0) <= integer(round(r * real(e_max_1 - e_min_1 + 1) + real(e_min_1) - 0.5));
        end loop;
        wait;
    end process;
    

end Behavioral;
