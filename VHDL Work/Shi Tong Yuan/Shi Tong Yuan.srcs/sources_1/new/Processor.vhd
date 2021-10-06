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
    
    component generate_A is
        port (
            generate_A    : in  std_logic ;
            q             : in integer;
            Matrix_A      : out matrixA_1
        );
    end component;
    
    component generate_s is
        port(
            config_num : in integer;
            q : in integer;
            s : out matrixS_1
        );
    end component;
    
    component generate_e is
        port(
            config_num : in integer;
            q : in integer;
            e : out matrixE_1
        );
    end component;
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1;
    signal A : matrixA_1;
    signal B : matrixB_1;
    signal E : matrixE_1;


    signal sig_generate_q : std_logic;
    signal sig_generate_S : std_logic;
    signal sig_generate_A : std_logic;
    signal sig_generate_B : std_logic;
    signal sig_generate_E : std_logic;

--   ====================== Other Self Test Signals ======================
    signal sig_clk : std_logic;
    signal config_num : integer := 1;
    
    signal q : integer;

begin

    program_counter : PC
    port map(
        clk => sig_clk);
    
    generate_q : q_generator
        port map(
            config_num => 1,
            reset => '1',
            clk => sig_clk,
            q => q
        );
        
    generate_Matrix_A : generate_A
        port map(
            generate_A => sig_generate_A,
            q => q,
            Matrix_A => A
        );

    generate_Matrix_S : generate_s
        port map(
            config_num => 1,
            q => q,
            s => S        
        );
        
        
    generate_Matrix_E : generate_e
        port map(
            config_num => 1,
            q => q,
            e => E        
        );

    
end Behavioral;