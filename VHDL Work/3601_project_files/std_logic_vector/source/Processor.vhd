library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity Processor is
    port (
        encode_string : in string(1 to 4);
        clk : in std_logic;
        result : out string(1 to 4)
    );
end Processor;

architecture Behavioral of Processor is
    component chars_to_ascii_array is
        Port ( 
            clk                 : in std_logic;
            encode_chars        : in string(1 to 4);
            
            ascii_array_out     : out ascii_array;
            sig_chars_loaded    : out std_logic
        );
    end component;
    
    component ascii_array_to_chars is
        Port ( 
            clk                   : in std_logic;
            sig_is_dec_generated  : in std_logic;
            ascii_array_in        : in ascii_array;
            
            decode_chars          : out string(1 to 4);
            sig_result_release    : out std_logic
        );
    end component;

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

            RowA_in        : in RowA_1;
            Matrix_S       : in matrixS_1;
            RowE_in        : in integer;
            
            store_B_row    : out integer;
            store_B_ele    : out integer
        );
    end component;
    
    component generate_UV is
        port (
            is_B_generated      : in std_logic;
            clk                 : in std_logic;
            q                   : in integer;
            ascii_bits_array    : in ascii_array;
            RowA_in             : in RowA_1;
            RowB_in             : in integer;
 
            random_row_num      : out integer;
            uv_row_num          : out integer;

            output_generated        : out std_logic;
            RowU_out            : out RowU_1;
            RowV_out            : out integer
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
    signal sig_ascii_array : ascii_array := (others=>(others=>'0'));
    signal sig_is_chars_loaded : std_logic := '0';
--============================== Char Load & To_Asciis =============================
    
--   ====================== Configuration Storage ======================
    signal S : matrixS_1 := (others => 0);
    signal A : matrixA_1 := (others => (others => 0));
    signal E : matrixE_1 := (others => 0);
    signal B : matrixB_1 := (others => 0);
    signal q : integer := 113;
--   ==== generation signals
    signal sig_is_S_generated : std_logic := '0';
    signal sig_is_A_generated : std_logic := '0';
    signal sig_is_E_generated : std_logic := '0';
    signal sig_is_B_generated : std_logic := '0';
--  ==== generate S
    signal sig_store_S_row : integer := 0;
    signal sig_store_S_element : integer := 0;
--  ==== generate A
    signal sig_store_A_row : integer := 0;
    signal sig_store_A_col : integer := 0;
    signal sig_store_A_element : integer := 0;
--  ==== generate E    
    signal sig_store_E_row : integer := 0;
    signal sig_store_E_element : integer := 0;
--  ==== generate B
    signal sig_RowA_in_B : RowA_1 := (others => 0);
    signal sig_RowE_in_B : integer := 0;

    signal sig_store_B_row : integer := 0;
    signal sig_store_B_element : integer := 0;
--   ====================== Configuration Storage ======================
    
--============================== Generate n/4 random row number for 4 cahrs =============================
    signal sig_random_row_num : integer := 0;
    signal sig_uv_row_num : integer := 0;
    signal sig_UV_output_generated : std_logic := '0';

    signal sig_RowA_in_UV : RowA_1 := (others => 0);
    signal sig_RowB_in_UV : integer := 0;
    
    signal sig_RowU_out_UV : RowU_1 := (0 to A_col_1 - 1 => 0);
    signal sig_RowV_out_UV : integer := 0;

    signal U_cells : U_storage := (others => (others => (others => 0)));
    signal V_cells : V_storage := (others => (others => 0));

    signal sig_is_UV_generated : std_logic := '0';
--============================== Generate n/4 random row number for 4 cahrs =============================
    signal sig_dec_ascii_array : ascii_array := (others=>(others=>'0'));
    signal sig_is_dec_finished : std_logic := '0';
    signal three_quar_q : integer := 0;
    signal quar_q : integer := 0;

    signal sig_is_result_released : std_logic := '0';
--   ====================== Other Self Test Signals ======================

begin
--============================== Char Load & To_Asciis =============================
    chars_to_asciis : chars_to_ascii_array      -- synthesizable now
    port map(
        clk => clk,
        encode_chars => encode_string,
        
        ascii_array_out => sig_ascii_array,
        sig_chars_loaded => sig_is_chars_loaded
    );
--============================== Char Load & To_Asciis =============================

--============================== Set Up =============================
    generate_Matrix_A : generate_A      -- synthesizable now
        port map(   
            clk => clk,
            q => q,
            store_row => sig_store_A_row,
            store_col => sig_store_A_col,
            store_ele => sig_store_A_element
        );
    
    store_A : process       -- synthesizable now
    begin
        for row in matrixA_1'range(1) loop
            for col in matrixA_1'range(2) loop
                wait until clk'event and clk = '0';
                A(sig_store_A_row, sig_store_A_col) <= sig_store_A_element;
            end loop;
        end loop;
        sig_is_A_generated <= '1';
        wait;
    end process;

    generate_Matrix_S : generate_s      -- synthesizable now
        port map(
            clk => clk,
            q => q,
            store_S_row => sig_store_S_row,
            store_S_ele => sig_store_S_element
        );
        
    store_S : process       -- synthesizable now
    begin
        for row in matrixS_1'range(1) loop
            wait until clk'event and clk = '0';
            S(sig_store_S_row) <= sig_store_S_element;
        end loop;
        sig_is_S_generated <= '1';
        wait;
    end process;
 
    generate_Matrix_E : generate_e      -- synthesizable now
        port map(
            clk => clk,
            q => q,
            store_E_row => sig_store_E_row,
            store_E_ele => sig_store_E_element
        );
        
    store_E : process       -- synthesizable now
    begin
        for row in matrixE_1'range(1) loop
            wait until clk'event and clk = '0';
            E(sig_store_E_row) <= sig_store_E_element;
        end loop;
        sig_is_E_generated <= '1';
        wait;

    end process;
    
    generate_Matrix_B : generate_B      -- synthesizable now
        port map(
            is_S_generated => sig_is_S_generated,
            is_A_generated => sig_is_A_generated,
            is_E_generated => sig_is_E_generated,
            clk => clk,
            q => q, 
                        
            RowA_in => sig_RowA_in_B,
            Matrix_S => S,
            RowE_in => sig_RowE_in_B,
            
            store_B_row => sig_store_B_row,
            store_B_ele => sig_store_B_element
        );
        
    store_B : process       -- synthesizable now
    begin
        if sig_is_A_generated = '1' and sig_is_S_generated = '1' and sig_is_E_generated = '1' and sig_is_B_generated = '0' then
            for i in matrixB_1'range(1) loop
                
                for j in matrixA_1'range(2) loop
                    sig_RowA_in_B(j) <= A(i,j);
                end loop;
                sig_RowE_in_B <= E(i); 
                wait until clk'event and clk = '0';
                B(sig_store_B_row) <= sig_store_B_element;
            end loop;
            sig_is_B_generated <= '1';
            wait;
        else
            wait until clk'event and clk = '0';
        end if;
    end process;
    
----============================== Set Up =============================

----============================== Generate n/4 random row number for 4 cahrs , set UV cells =============================
    storage_UV_output : process         -- synthesizable now
        variable i : integer := 1;
        variable j : integer := 0;
        variable count : integer := 0;
    begin
        if sig_UV_output_generated = '1' then
            if count < 32 then
                U_cells(i)(j, 0) <= sig_RowU_out_UV(0);
                U_cells(i)(j, 1) <= sig_RowU_out_UV(1);
                U_cells(i)(j, 2) <= sig_RowU_out_UV(2);
                U_cells(i)(j, 3) <= sig_RowU_out_UV(3);
                
                V_cells(i,j) <= sig_RowV_out_UV;
                count := count + 1;
                j := j + 1;
                if j = 8 then
                    j := 0;
                    i := i + 1;
                end if;
            end if;
            wait until clk'event and clk='1';
        else
            wait until clk'event and clk='1';
        end if;
    end process;
        
    storage_UV_input : process
        variable i : integer := 1;
        variable j : integer := 0;
        variable k : integer := 0;
    begin
--        if sig_is_B_generated = '1' then
--            for i in ascii_array'range(1) loop
--                for j in 0 to 7 loop
--                    -- input
--                    for k in 0 to A_row_1 / 4 - 1 loop
--                        sig_RowA_in_UV(0) <= A(sig_random_row_num, 0);
--                        sig_RowA_in_UV(1) <= A(sig_random_row_num, 1);
--                        sig_RowA_in_UV(2) <= A(sig_random_row_num, 2);
--                        sig_RowA_in_UV(3) <= A(sig_random_row_num, 3);
                               
--                        sig_RowB_in_UV <= B(sig_random_row_num);
--                        wait until clk'event and clk='0';
--                    end loop;
--                end loop;
--            end loop;
--            wait;
--        else
--            wait until clk'event and clk='0';
--        end if;

        if sig_is_B_generated = '1' then
            if i < 5 then
                if j < 8 then
                    if k < A_row_1 / 4 - 1 then
                        sig_RowA_in_UV(0) <= A(sig_random_row_num, 0);
                        sig_RowA_in_UV(1) <= A(sig_random_row_num, 1);
                        sig_RowA_in_UV(2) <= A(sig_random_row_num, 2);
                        sig_RowA_in_UV(3) <= A(sig_random_row_num, 3);
                               
                        sig_RowB_in_UV <= B(sig_random_row_num);
                        k := k + 1;
                    elsif k = A_row_1 / 4 - 1 then
                        k := 0;
                        j := j + 1;
                    end if;
                elsif j = 8 then
                    j := 0;
                    i := i + 1;
                end if;
            elsif i = 5 then
                sig_is_UV_generated <= '1';
                wait;
            end if;
        end if;
        wait until clk'event and clk='0';
    end process;
    
    generate_Cells_UV : generate_UV             -- synthesizable now
        port map(
            is_B_generated => sig_is_B_generated,
            clk => clk,
            q => q,
            ascii_bits_array => sig_ascii_array,
            RowA_in => sig_RowA_in_UV,
            RowB_in => sig_RowB_in_UV,

            random_row_num => sig_random_row_num,
            uv_row_num => sig_uv_row_num,

            output_generated => sig_UV_output_generated,
            RowU_out => sig_RowU_out_UV,
            RowV_out => sig_RowV_out_UV
        );
----============================== Generate n/4 random row number for 4 cahrs , set UV cells =============================

--=================== decryption to dec_ascii_array =====================
    generate_dec : process
        variable RowU_0 : integer := 0;
        variable RowU_1 : integer := 0;
        variable RowU_2 : integer := 0;
        variable RowU_3 : integer := 0;
        variable RowV   : integer := 0;
        variable tmp   : integer := 0;
    begin
        if sig_is_UV_generated = '1' then
            case (3*q mod 4) is
                when 0 => three_quar_q <= (3*q/4);
                when 1 => three_quar_q <= (3*q - 1)/4;
                when 2 => three_quar_q <= (3*q + 2)/4;
                when others => three_quar_q <= (3*q + 1)/4;
            end case;
            
            case (q mod 4) is
                when 0 => quar_q <= (q/4);
                when 1 => quar_q <= (q - 1)/4;
                when 2 => quar_q <= (q + 2)/4;
                when others => quar_q <= (q + 1)/4;
            end case;
        
            for i in ascii_array'range loop
                for j in 0 to 7 loop
                    RowU_0 := U_cells(i)(j,0);
                    RowU_1 := U_cells(i)(j,1);
                    RowU_2 := U_cells(i)(j,2);
                    RowU_3 := U_cells(i)(j,3);
                    RowV := V_cells(i,j);
                    
                    tmp := (RowV - (RowU_0 * S(0) + RowU_1 * S(1) + RowU_2 * S(2) + RowU_3 * S(3))) mod q;

                    if tmp > three_quar_q or tmp < quar_q then
                        sig_dec_ascii_array(i)(j) <= '0';
                    else
                        sig_dec_ascii_array(i)(j) <= '1';
                    end if;
                    wait until clk'event and clk='0';
                end loop;
            end loop;
            sig_is_dec_finished <= '1';
            wait;
        else
            wait until clk'event and clk='0';
        end if;
    end process;
--=================== decryption to dec_ascii_array =====================
    
--================== final stage : convert ascii array to chars ===========================
    ascii_to_chars : ascii_array_to_chars
        port map(
            clk => clk,
            sig_is_dec_generated => sig_is_dec_finished,
            ascii_array_in => sig_dec_ascii_array,
            
            decode_chars => result,
            sig_result_release => sig_is_result_released
        );
--================== final stage : convert ascii array to chars ===========================
end Behavioral;