Library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.std_logic_arith.all ;
entity random_generator_8 is
   generic (data_width    : natural := 8 );
   port (
         clk      : in  std_logic ;
         reset    : in  std_logic ;
         data_out : out UNSIGNED(data_width - 1 downto 0)
        );
end random_generator_8 ;

architecture rtl of random_generator_8 is  
  signal feedback : std_logic ;
  signal lfsr_reg : UNSIGNED(data_width - 1 downto 0) ;
  signal control : std_logic := '1';
  begin
    feedback <= lfsr_reg(7) xor lfsr_reg(0) ;
  latch_it :  process(clk,reset)
       begin
          if (reset = '0') and control = '1' then
           lfsr_reg <= "00101101" ;
           control <= '0';
          elsif (clk = '1' and clk'event) then
            lfsr_reg <= lfsr_reg(lfsr_reg'high - 1 downto 0) & feedback ;
          end if;
        end process ;
   data_out <= lfsr_reg ;
end rtl ;