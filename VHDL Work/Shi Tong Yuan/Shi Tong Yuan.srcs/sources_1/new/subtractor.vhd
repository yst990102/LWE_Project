library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor is
    Port ( q : in STD_LOGIC_VECTOR (12 downto 0);
           is_decrt : in STD_LOGIC;
           v_in : in STD_LOGIC_VECTOR (12 downto 0);
           input : in STD_LOGIC_VECTOR (12 downto 0);
           output : out std_logic_vector (12 downto 0));
end subtractor;

architecture Behavioral of subtractor is
    signal unmod_diff : integer;
    signal q_by_2 : STD_LOGIC_VECTOR (12 downto 0);
begin
    process (is_decrt, v_in, q, input)
    begin
        q_by_2 <= '0' & q(12 downto 1);
        if is_decrt = '1' then
            unmod_diff <= to_integer(signed(v_in)) - to_integer(signed(input));
            output <= std_logic_vector(to_unsigned(((unmod_diff) mod (to_integer(unsigned(q)))), output'length));
        else
            unmod_diff <= to_integer(signed(input)) - (to_integer(signed(q_by_2)));
            output <= std_logic_vector(to_unsigned(((unmod_diff) mod (to_integer(unsigned(q)))), output'length));            
        end if;
    end process;
end Behavioral;
