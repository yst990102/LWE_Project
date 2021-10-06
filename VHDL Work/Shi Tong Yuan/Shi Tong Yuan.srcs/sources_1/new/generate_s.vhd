library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
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
    s(0, 0) <= (q);
    s(1, 0) <= (q);
    s(2, 0) <= (q);
    s(3, 0) <= (q);
    

end Behavioral;
