library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2to1_nb is
    GENERIC (n  : INTEGER := 16);
    Port ( A : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(n-1 DOWNTO 0));
end MUX_2to1_nb;

architecture Behavioral of MUX_2to1_nb is
    component MUX_2to1_1b is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           sel : in STD_LOGIC;
           output : out STD_LOGIC);
    end component;
begin
    muxes: for i in n-1 downto 0 generate
        bit_mux: MUX_2to1_1b 
        port map(   A => A(i),
                    B => B(i),
                    sel => sel,
                    output => output(i) );
   end generate muxes;

end Behavioral;
