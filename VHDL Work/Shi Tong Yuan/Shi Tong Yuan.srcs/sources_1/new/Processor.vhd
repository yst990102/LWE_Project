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

--    ====================== Configurations =======================    
--    ==== Configuration 01
    signal size_A_rows_1 : integer := 256;
    signal Size_A_cols_1 : integer := 4;
    
    signal q_min_1 : integer := 1;
    signal q_max_1 : integer := 128;
    
    signal e_min_1 : integer := -1;
    signal e_max_1 : integer := 1;
    
----    ==== Configuration 02
--    signal size_A_rows_2 : integer := 8192;
--    signal Size_A_cols_2 : integer := 8;
    
--    signal q_min_2 : integer := 2048;
--    signal q_max_2 : integer := 8192;
    
--    signal e_min_2 : integer := -4;
--    signal e_max_2 : integer := 4;
    
----    ==== Configuration 03
--    signal size_A_rows_3 : integer := 32768;
--    signal Size_A_cols_3 : integer := 16;
    
--    signal q_min_3 : integer := 16384;
--    signal q_max_3 : integer := 65535;
    
--    signal e_min_3 : integer := -16;
--    signal e_max_3 : integer := 16;

--    ====================== Configuration Types ======================
--    ==== Configuration 01 Type
    type matrixS_1 is array (0 to size_A_cols_1, 0 to 1) of integer range e_min_1 to e_max_1;
    type matrixA_1 is array (0 to size_A_rows_1, 0 to size_A_cols_1) of integer range q_min_1 to q_max_1;
    type matrixB_1 is array (0 to size_A_rows_1, 0 to 1) of integer;
    type matrixE_1 is array (0 to size_A_rows_1, 0 to 1) of integer range e_min_1 to e_max_1;
    type matrixU_1 is array (0 to size_A_cols_1, 0 to 1) of integer range q_min_1 to q_max_1;
    
----    ==== Configuration 02 Type
--    type matrixS_2 is array (0 to size_A_cols_2, 0 to 1) of integer range e_min_2 to e_max_2;
--    type matrixA_2 is array (0 to size_A_rows_2, 0 to size_A_cols_2) of integer range q_min_2 to q_max_2;
--    type matrixB_2 is array (0 to size_A_rows_2, 0 to 1) of integer;
--    type matrixE_2 is array (0 to size_A_rows_2, 0 to 1) of integer range e_min_2 to e_max_2;
--    type matrixU_2 is array (0 to size_A_cols_2, 0 to 1) of integer range q_min_2 to q_max_2;
    
----    ==== Configuration 03 Type
--    type matrixS_3 is array (0 to size_A_cols_3, 0 to 1) of integer range e_min_3 to e_max_3;
--    type matrixA_3 is array (0 to size_A_rows_3, 0 to size_A_cols_3) of integer range q_min_3 to q_max_3;
--    type matrixB_3 is array (0 to size_A_rows_3, 0 to 1) of integer;
--    type matrixE_3 is array (0 to size_A_rows_3, 0 to 1) of integer range e_min_3 to e_max_3;
--    type matrixU_3 is array (0 to size_A_cols_3, 0 to 1) of integer range q_min_3 to q_max_3;
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1;
    signal A : matrixA_1;
    signal B : matrixB_1;
    signal E : matrixE_1;
    
    signal generate_S : std_logic;
    signal generate_A : std_logic;
    signal generate_B : std_logic;
    signal generate_E : std_logic;


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