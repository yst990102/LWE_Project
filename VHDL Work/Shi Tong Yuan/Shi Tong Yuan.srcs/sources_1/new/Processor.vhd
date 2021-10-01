library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
end Processor;

architecture Behavioral of Processor is
    component PC is 
        port(
             clk : out std_logic);
    end component;
    
    component random_generator_16 is
    port (
        por:                buffer  std_logic;
        clk:            in  std_logic;
        random_flag:        in  std_logic;
        random_data:        out std_logic_vector (15 downto 0)
    );
    end component;
    
    component random_generator_8 is
        generic (data_width : natural := 8 );
        port(
            reset : in std_logic;
            clk : in std_logic);
    end component;

--    ====================== Configuration Types ======================
--    ==== Configuration 01 Type
    type matrixS_1 is array (0 to 4,   0 to 1) of integer range 1 to 128;
    type matrixA_1 is array (0 to 256, 0 to 4) of integer range 1 to 128;
    type matrixB_1 is array (0 to 256, 0 to 1) of integer range 1 to 128;
    type matrixE_1 is array (0 to 256, 0 to 1) of integer range -1 to 1;
    type matrixU_1 is array (0 to 4,   0 to 1) of integer range 1 to 128;
    
--    ==== Configuration 02 Type
    type matrixS_2 is array (0 to 8,    0 to 1) of integer range 2048 to 8192;
    type matrixA_2 is array (0 to 8192, 0 to 8) of integer range 2048 to 8192;
    type matrixB_2 is array (0 to 8192, 0 to 1) of integer range 2048 to 8192;
    type matrixE_2 is array (0 to 8192, 0 to 1) of integer range -4 to 4;
    type matrixU_2 is array (0 to 8,    0 to 1) of integer range 2048 to 8192;
    
--    ==== Configuration 03 Type
    type matrixS_3 is array (0 to 16,    0 to 1 ) of integer range 16384 to 65535;
    type matrixA_3 is array (0 to 32768, 0 to 16) of integer range 16384 to 65535;
    type matrixB_3 is array (0 to 32768, 0 to 1 ) of integer range 16384 to 65535;
    type matrixE_3 is array (0 to 32768, 0 to 1 ) of integer range -16 to 16;
    type matrixU_3 is array (0 to 16,    0 to 1 ) of integer range 16384 to 65535;
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1;
    signal A : matrixA_1;
    signal B : matrixB_1;
    signal E : matrixE_1;
    
    signal generate_S : std_logic;
    signal generate_A : std_logic;
    signal generate_B : std_logic;
    signal generate_E : std_logic;

--   ====================== Other Self Test Signals ======================
    signal sig_clk : std_logic;
    signal sig_por: std_logic := '0';
    signal sig_random_flag : std_logic := '1';
    signal random_data : std_logic_vector(15 downto 0);
begin

    program_counter : PC
    port map(
        clk => sig_clk);

    
    lfst_random01: random_generator_16
        port map(
            por                 => sig_por,                
            clk             => sig_clk,
            random_flag         => sig_random_flag,
            random_data         => random_data
        );
    
    lfst_random02: random_generator_8
        port map(
            reset => sig_por,
            clk => sig_clk
        );
    
end Behavioral;