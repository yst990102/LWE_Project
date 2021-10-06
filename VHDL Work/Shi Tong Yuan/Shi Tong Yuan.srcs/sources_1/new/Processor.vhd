library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.packages.all;

entity Processor is
end Processor;

architecture Behavioral of Processor is
    component PC is 
        port(
             clk : out std_logic);
    end component;
    
    component q_generator is
    port(
            config_num : in integer;
            reset : in std_logic;
            clk : in std_logic;
            q : out integer
        );
    end component;
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1;
    signal A : matrixA_1;
    signal B : matrixB_1;
    signal E : matrixE_1;
    signal q : integer;

    
    signal generate_S : std_logic;
    signal generate_A : std_logic;
    signal generate_B : std_logic;
    signal generate_E : std_logic;

--   ====================== Other Self Test Signals ======================
    signal sig_clk : std_logic;

begin

    program_counter : PC
    port map(
        clk => sig_clk);
    
    generate_q : q_generator
        port map(
            config_num => 2,
            reset => '0',
            clk => sig_clk,
            q => q
        );

    
end Behavioral;