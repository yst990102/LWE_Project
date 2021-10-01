library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity random_generator_16 is
    port (
        por:                in  std_logic;
        clk:            in  std_logic;
        random_flag:        in  std_logic;
        random_data:        out std_logic_vector (15 downto 0)
    );
end entity random_generator_16;

architecture behavioral of random_generator_16 is
    signal q:             std_logic_vector(15 downto 0);
    signal n1, n2, n3:    std_logic;
    
    signal control : std_logic := '1';
begin
    process (por, clk) -- ADDED por to sensitivity list
    begin
        if por = '0'and control = '1' then 
            q <= "1001101001101010";
            control <= '0';
        elsif (clk = '1' and clk'event) then
            if random_flag = '1' then
                -- REMOVED intermediary products as flip flops
                q <= q(14 downto 0) & n3;  -- REMOVED after 10 ns;
            end if;
        end if;
    end process;
    -- MOVED intermediary products to concurrent signal assignments:
    n1 <= q(15) xor q(13);
    n2 <= n1 xor q(11); --  REMOVED after 10 ns;
    n3 <= n2 xor q(10); --  REMOVED after 10 ns;

    random_data <= q;
end architecture behavioral;