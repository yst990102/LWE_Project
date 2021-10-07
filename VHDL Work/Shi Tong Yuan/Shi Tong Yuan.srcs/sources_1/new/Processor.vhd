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
            store_row     : out integer;
            store_col     : out integer;
            store_ele     : out integer
        );
    end component;
    
    component generate_s is
        port(
            clk         : in std_logic;
            q           : in integer;
            store_S_row : out integer;
            store_S_ele : out integer
        );
    end component;
    
    component generate_e is
        port(
            clk     : in std_logic;
            q       : in integer;
            store_E_row : out integer;
            store_E_ele : out integer
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

    signal sig_is_S_generated : std_logic := '0';
    signal sig_is_A_generated : std_logic := '0';
    signal sig_is_E_generated : std_logic := '0';
    
    signal sig_is_B_generated : std_logic := '0';
    
    signal sig_store_A_row : integer;
    signal sig_store_A_col : integer;
    signal sig_store_A_element : integer;
    
    signal sig_store_S_row : integer;
    signal sig_store_S_element : integer;
    
    signal sig_store_E_row : integer;
    signal sig_store_E_element : integer;
    
--   ====================== Other Self Test Signals ======================

begin
    generate_Matrix_A : generate_A
        port map(
            clk => clk,
            q => q,
            store_row => sig_store_A_row,
            store_col => sig_store_A_col,
            store_ele => sig_store_A_element
        );
    
    store_A : process
    begin
        while sig_is_A_generated = '0' loop
            wait for 20ps;
            A(sig_store_A_row, sig_store_A_col) <= sig_store_A_element;
            
            if sig_store_A_row = A_row_1 -1 and sig_store_A_col = A_col_1 -1 then
                sig_is_A_generated <= '1';
            end if;
        end loop;
        wait;
    end process;

    generate_Matrix_S : generate_s
        port map(
            clk => clk,
            q => q,
            store_S_row => sig_store_S_row,
            store_S_ele => sig_store_S_element
        );
        
    store_S : process
    begin
        while sig_is_S_generated = '0' loop
            wait for 20ps;
            S(sig_store_S_row, 0) <= sig_store_S_element;
            
            if sig_store_S_row = A_col_1 - 1 then
                sig_is_S_generated <= '1';
            end if;
        end loop;
        wait;
    end process;
 
    generate_Matrix_E : generate_e
        port map(
            clk => clk,
            q => q,
            store_E_row => sig_store_E_row,
            store_E_ele => sig_store_E_element
        );
        
    store_E : process
    begin
        while sig_is_E_generated = '0' loop
            wait for 20ps;
            E(sig_store_E_row, 0) <= sig_store_E_element;
            
            if sig_store_E_row = A_row_1 - 1 then
                sig_is_E_generated <= '1';
            end if;
        end loop;
        wait;
    end process;
    
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