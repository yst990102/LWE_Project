library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comparator is
    generic (n : integer := 12);
    Port ( q : in STD_LOGIC_VECTOR (n-1 downto 0);
           dec : in STD_LOGIC_VECTOR (n-1 downto 0);
           M : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is
    signal q_by_2 : std_logic_vector(n-1 downto 0);
begin
    process (q, dec) is
    begin
        q_by_2 <= '0' & q(n-1 downto 1);
        if to_integer(unsigned(dec)) < to_integer(unsigned(q_by_2)) then
            M <= '0';
        else
            M <= '1';
        end if;
        
    end process;

end Behavioral;
