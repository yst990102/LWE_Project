Library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.std_logic_arith.all ;

entity random_generator is
    generic (data_width    : natural);
    port (
        seed     : in integer;
        clk      : in  std_logic ;
        reset    : in  std_logic ;
        data_out : out integer
        );
end random_generator ;

architecture rtl of random_generator is  
    signal feedback : std_logic ;
    signal lfsr_reg : UNSIGNED(data_width - 1 downto 0) ;
    signal run : std_logic := '0';
begin
    feedback <= lfsr_reg(data_width - 1) xor lfsr_reg(0) ;
    
    latch_it :  
    process(clk,reset)
    begin
        if (reset = '1') and run = '0' then
            lfsr_reg <= conv_unsigned(seed, data_width);  --- seed
            run <= '1';
        elsif (clk = '1' and clk'event) then
            lfsr_reg <= lfsr_reg(lfsr_reg'high - 1 downto 0) & feedback ;
        end if;
    end process ;
    
    data_out <= conv_integer(lfsr_reg) ;
end rtl ;