library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.packages.all;

entity Processor is
    port (
        clk : in std_logic
    );
end Processor;

architecture Behavioral of Processor is    
    component generate_A is
        port (
            clk           : in std_logic;
            q             : in integer;
            Matrix_A      : out matrixA_1;
            state         : out std_logic
        );
    end component;
    
    component generate_s is
        port(
            clk         : in std_logic;
            q           : in integer;
            Matrix_S    : out matrixS_1;
            state       : out std_logic
        );
    end component;
    
    component generate_e is
        port(
            clk     : in std_logic;
            q       : in integer;
            Matrix_E       : out matrixE_1;
            state   : out std_logic
        );
    end component;
    
    component generate_B is
        port(
            is_S_generated : in std_logic;
            is_A_generated : in std_logic;
            is_E_generated : in std_logic;
            clk            : in std_logic;
            q              : in integer;
            Matrix_A       : in matrixA_1;
            Matrix_S       : in matrixS_1;
            Matrix_E       : in matrixE_1;
            Matrix_B       : out matrixB_1;
            state          : out std_logic
        );
    end component;
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1;
    signal A : matrixA_1;
    signal B : matrixB_1;
    signal E : matrixE_1;
    signal q : integer := 113;

    signal sig_is_S_generated : std_logic;
    signal sig_is_A_generated : std_logic;
    signal sig_is_E_generated : std_logic;
    
    signal sig_is_B_generated : std_logic;

--   ====================== Other Self Test Signals ======================

begin
    generate_Matrix_A : generate_A
        port map(
            clk => clk,
            q => q,
            Matrix_A => A,
            state => sig_is_A_generated
        );

    generate_Matrix_S : generate_s
        port map(
            clk => clk,
            q => q,
            Matrix_S => S,
            state => sig_is_S_generated
        );
 
    generate_Matrix_E : generate_e
        port map(
            clk => clk,
            q => q,
            Matrix_E => E,
            state => sig_is_E_generated
        );
    
    generate_Matrix_B : generate_B
        port map(
            is_S_generated => sig_is_S_generated,
            is_A_generated => sig_is_A_generated,
            is_E_generated => sig_is_E_generated,
            clk => clk,
            q => q, 
            Matrix_A => A,
            Matrix_S => S,
            Matrix_E => E,
            Matrix_B => B,
            state => sig_is_B_generated
        );
    
end Behavioral;