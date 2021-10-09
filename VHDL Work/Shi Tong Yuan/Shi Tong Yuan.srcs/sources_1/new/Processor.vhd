library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity Processor is
    port (
        encode_string : in string(1 to 4);
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
            
            store_B_row    : out integer;
            store_B_ele    : out integer
        );
    end component;
    
    component random_generator is
        generic (data_width : natural);
        port(
            seed : in integer;
            reset : in std_logic;
            clk : in std_logic;
            data_out : out integer);
    end component;

--============================== Char Load & To_Asciis =============================
    type ascii_array is array (1 to 4) of unsigned(0 to 7); 
    signal sig_ascii_array : ascii_array;
--============================== Char Load & To_Asciis =============================
    
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
        
    signal sig_store_B_row : integer;
    signal sig_store_B_element : integer;
--   ====================== Configuration Storage ======================
    
--============================== Generate n/4 random row number for 4 cahrs =============================
    type U_cell is array (0 to 7, 0 to A_col_1 - 1) of integer;
    type U_storage is array (1 to 4) of U_cell;
    signal U_cells : U_storage;
    
    type V_cell is array (0 to 7) of integer;
    type V_storage is array(1 to 4) of V_cell;
    signal V_cells : V_storage;
    
    signal row_num_random_result : integer;    
    signal sig_is_U_generated : std_logic;
    
    signal sig_first_sum : integer;
    signal sig_second_sum : integer;
    signal sig_third_sum : integer;
    signal sig_forth_sum : integer;
    
    signal sig_fifth_sum : integer;
--============================== Generate n/4 random row number for 4 cahrs =============================
--   ====================== Other Self Test Signals ======================

begin
--============================== Char Load & To_Asciis =============================
    string_to_asciis : process
    begin
        for i in 1 to 4 loop
            sig_ascii_array(i) <= conv_unsigned(integer(character'pos(encode_string(i))), 8);
            wait for 20ps;
        end loop;
        wait;
    end process;
--============================== Char Load & To_Asciis =============================

--============================== Set Up =============================
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
            store_B_row => sig_store_B_row,
            store_B_ele => sig_store_B_element
        );
        
    store_B : process
    begin
        if sig_is_A_generated = '1' and sig_is_S_generated = '1' and sig_is_E_generated = '1' then
            while sig_is_B_generated = '0' loop
                wait for 20ps;
                B(sig_store_B_row, 0) <= sig_store_B_element;
                
                if sig_store_B_row = A_row_1 - 1 then
                    sig_is_B_generated <= '1';
                end if;
            end loop;
            wait;
        else
            wait for 20ps;
        end if;
    end process;
    
--============================== Set Up =============================

--============================== Generate n/4 random row number for 4 cahrs =============================
    random_number: random_generator
        generic map (data_width => 7 )
        port map(
            seed => 220,
            reset => '1',
            clk => clk,
            data_out => row_num_random_result
        );
        
    generate_random_rows : process
        variable encoding_ascii : unsigned(0 to 7);
        variable first_ele, second_ele, third_ele, forth_ele : integer;
        variable first_sum, second_sum, third_sum, forth_sum, fifth_sum : integer;
    begin
        if sig_is_B_generated = '1' then
            for row in 1 to 4 loop
                encoding_ascii := sig_ascii_array(row);

                for i in encoding_ascii'range(1) loop
                    first_sum := 0;
                    second_sum := 0;
                    third_sum := 0;
                    forth_sum := 0;
                    fifth_sum := 0;
                    for col in 0 to (A_row_1 / 4 - 1) loop
                        first_sum := first_sum + A(row_num_random_result, 0);
                        second_sum := second_sum + A(row_num_random_result, 1);
                        third_sum := third_sum + A(row_num_random_result, 2);
                        forth_sum := forth_sum + A(row_num_random_result, 3);
                        
                        sig_first_sum <= first_sum;
                        sig_second_sum <= second_sum;
                        sig_third_sum <= third_sum;
                        sig_forth_sum <= forth_sum;
                        
                        fifth_sum := fifth_sum + B(row_num_random_result, 0);
                        
                        sig_fifth_sum <= fifth_sum;
                        wait for 20ps;
                    end loop;
                    
                    U_cells(row)(i,0) <= first_sum mod q;
                    U_cells(row)(i,1) <= second_sum mod q;
                    U_cells(row)(i,2) <= third_sum mod q;
                    U_cells(row)(i,3) <= forth_sum mod q;
                    
                    V_cells(row)(i) <= (fifth_sum - (q/2) * i) mod q;
                end loop;
                
            end loop;
            sig_is_U_generated <= '1';
            wait;
        else
            wait for 20ps;
        end if;
    end process;
--============================== Generate n/4 random row number for 4 cahrs =============================
    
    
end Behavioral;