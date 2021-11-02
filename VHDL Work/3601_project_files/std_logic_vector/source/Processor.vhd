library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity Processor is
    port (
        encode_string   : in string(1 to string_length);
        clk             : in std_logic;
        sig_reset       : in std_logic;
        txt_input       : in std_logic;
        multi_type      : in integer;

        result          : out string(1 to string_length)
    );
end Processor;

architecture Behavioral of Processor is
    -- ================= chars - ascii_array convertions =======================
    component chars_to_ascii_array is
        Port ( 
            clk                 : in std_logic;
            encode_chars        : in string(1 to string_length);
            
            ascii_array_out     : out ascii_array;
            sig_chars_loaded    : out std_logic
        );
    end component;
    
    component ascii_array_to_chars is
        Port ( 
            clk                   : in std_logic;
            reset                 : in std_logic;
            sig_is_dec_generated  : in std_logic;
            ascii_array_in        : in ascii_array;
            
            decode_string         : out string(1 to string_length);
            sig_result_release    : out std_logic
        );
    end component;
    -- ================= chars - ascii_array convertions =======================

    -- ================= generate A by LFSR =======================
    component generate_A is
        port (
            clk           : in std_logic;
            q             : in integer;
            txt_input     : in std_logic;

            store_A_row     : out integer;
            store_A_col     : out integer;
            store_A_ele     : out integer
        );
    end component;
    -- ================= generate A by LFSR =======================
    
    -- ================= generate A by FILE =======================
    component generate_A_by_file is
        port(
            clk : in std_logic;
            txt_input : in std_logic;
    
            A_row : out integer;
            A_out : out RowA_1;
            file_end : out std_logic
        );
    end component;
    -- ================= generate A by FILE =======================

    -- ================= generate S by LFSR =======================
    component generate_s is
        port(
            clk         : in std_logic;
            q           : in integer;
            txt_input   : in std_logic;

            store_S_row : out integer;
            store_S_ele : out integer
        );
    end component;
    -- ================= generate S by LFSR =======================
    
    -- ================= generate S by FILE =======================
    component generate_S_by_file is
        port(
            clk : in std_logic;
            txt_input : in std_logic;
    
            S_row : out integer;
            S_out : out integer;
            file_end : out std_logic
        );
    end component;
    -- ================= generate S by FILE =======================

    -- ================= generate E by LFSR =======================
    component generate_e is
        port(
            clk     : in std_logic;
            q       : in integer;
            txt_input   : in std_logic;

            store_E_row : out integer;
            store_E_ele : out integer
        );
    end component;
    -- ================= generate E by LFSR =======================
    
    -- ================= generate E by FILE =======================
    component generate_E_by_file is
        port(
            clk : in std_logic;
            txt_input : in std_logic;

            E_row : out integer;
            E_out : out integer;
            file_end : out std_logic
        );
    end component;
    -- ================= generate E by FILE =======================

    -- ================= generate B by multiplier_type =======================
    component generate_B is
        port(
            is_S_generated : in std_logic;
            is_A_generated : in std_logic;
            is_E_generated : in std_logic;

            clk            : in std_logic;
            q              : in integer;
            multi_type     : in integer;

            RowA_in        : in RowA_1;
            Matrix_S       : in matrixS_1;
            RowE_in        : in integer;
            
            store_B_row    : out integer;
            store_B_ele    : out integer
        );
    end component;
    -- ================= generate B by multiplier_type =======================

    -- ================= generate UV cells =======================
    component generate_UV is
        port (
            is_B_generated      : in std_logic;
            clk                 : in std_logic;
            q                   : in integer;
            reset               : in std_logic;
            ascii_bits_array    : in ascii_array;
            RowA_in             : in RowA_1;
            RowB_in             : in integer;
 
            random_row_num      : out integer;
            uv_row_num          : out integer;

            output_generated    : out std_logic;
            RowU_out            : out RowU_1;
            RowV_out            : out integer
        );
    end component;
    -- ================= generate UV cells =======================
    
    -- ================= LFSR random generateor =======================
    component random_generator is
        generic (data_width : natural);
        port(
            seed        : in integer;
            reset       : in std_logic;
            clk         : in std_logic;

            data_out    : out integer);
    end component;
    -- ================= LFSR random generateor =======================
-- ============================== statements =================================
--    type t_state is (reseting, generating_ASE, generating_B, generating_UV, decrypting, finished);
--    signal State : t_state;
-- ============================== statements =================================

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
--   ==== generation signals by LFSR
    signal sig_is_S_generated : std_logic := '0';
    signal sig_is_A_generated : std_logic := '0';
    signal sig_is_E_generated : std_logic := '0';
    signal sig_is_B_generated : std_logic := '0';
--  ==== generate S by LFSR
    signal sig_store_S_row : integer := 0;
    signal sig_store_S_element : integer := 0;
--  ==== generate A by LFSR
    signal sig_store_A_row : integer := 0;
    signal sig_store_A_col : integer := 0;
    signal sig_store_A_element : integer := 0;
--  ==== generate E by LFSR
    signal sig_store_E_row : integer := 0;
    signal sig_store_E_element : integer := 0;

--  ==== is_file_end by FILE
    signal sig_is_S_file_end : std_logic := '0';
    signal sig_is_A_file_end : std_logic := '0';
    signal sig_is_E_file_end : std_logic := '0';
--  ==== generate S by FILE
    signal sig_store_S_row_File : integer := 0;
    signal sig_store_S_element_File : integer := 0;
--  ==== generate A by FILE
    signal sig_store_A_row_File : integer := 0;
    signal sig_store_A_element_File : RowA_1 := (others => 0);
--  ==== generate E by FILE
    signal sig_store_E_row_File : integer := 0;
    signal sig_store_E_element_File : integer := 0;


--  ==== generate B
    signal sig_RowA_in_B : RowA_1 := (others => 0);
    signal sig_RowE_in_B : integer := 0;

    signal sig_store_B_row : integer := 0;
    signal sig_store_B_element : integer := 0;
--   ====================== Configuration Storage ======================
    
--============================== Generate n/4 random row number for 4 cahrs =============================
    signal sig_random_row_num : integer := 0;
    signal sig_UV_row_num : integer := 0;
    signal sig_UV_output_generated : std_logic := '0';

    signal sig_RowA_in_UV : RowA_1 := (others => 0);
    signal sig_RowB_in_UV : integer := 0;
    
    signal sig_RowU_out_UV : RowU_1 := (others => 0);
    signal sig_RowV_out_UV : integer := 0;

    signal U_cells : U_storage := (others => (others => (others => 0)));
    signal V_cells : V_storage := (others => (others => 0));

    signal sig_is_UV_generated : std_logic := '0';
--============================== Generate n/4 random row number for 4 cahrs =============================
    signal sig_dec_ascii_array : ascii_array := (others => (others => '0'));
    signal sig_is_dec_finished : std_logic := '0';
    signal three_quar_q : integer := 0;
    signal quar_q : integer := 0;

    signal sig_is_result_released : std_logic := '0';
    
--====================== Other Self Test Signals ======================

begin
--============================== Char Load & To_Asciis =============================
    chars_to_asciis : chars_to_ascii_array      
    port map(
        clk => clk,
        encode_chars => encode_string,
        
        ascii_array_out => sig_ascii_array,
        sig_chars_loaded => sig_is_chars_loaded
    );
--============================== Char Load & To_Asciis =============================

--============================== Set Up =============================            
--======================= Matrix A =============================
    generate_Matrix_A_LFSR : generate_A
        port map(   
            clk => clk,
            q => q,
            txt_input => txt_input,

            store_A_row => sig_store_A_row,
            store_A_col => sig_store_A_col,
            store_A_ele => sig_store_A_element
        );
    
    store_A : process
        variable row : integer := 0;
        variable col : integer := 0;
    begin
        if txt_input = '0' then
            if row < A_row_1 then
                if col < A_col_1 then
                    wait until clk'event and clk = '0';
                    A(sig_store_A_row, sig_store_A_col) <= sig_store_A_element;
                    col := col + 1;
                else
                    col := 0;
                    row := row + 1;
                end if;
            else
                sig_is_A_generated <= '1';
                wait;
            end if;
        else
            if row < A_row_1 then
                wait until clk'event and clk = '0';
                A(sig_store_A_row_File, 0) <= sig_store_A_element_File(0);
                A(sig_store_A_row_File, 1) <= sig_store_A_element_File(1);
                A(sig_store_A_row_File, 2) <= sig_store_A_element_File(2);
                A(sig_store_A_row_File, 3) <= sig_store_A_element_File(3);

                row := row + 1;
            else
                sig_is_A_generated <= '1';
                wait;
            end if;
        end if;
    end process;

    generate_Matrix_A_FILE : generate_A_by_file
        port map(
            clk => clk,
            txt_input => txt_input,

            A_row => sig_store_A_row_File,
            A_out => sig_store_A_element_File,
            file_end => sig_is_A_file_end
        );


--======================= Matrix A =============================

--======================= Matrix S =============================
    generate_Matrix_S_LFSR : generate_s
        port map(
            clk => clk,
            q => q,
            txt_input => txt_input,

            store_S_row => sig_store_S_row,
            store_S_ele => sig_store_S_element
        );
        
    store_S : process
        variable col : integer := 0;
    begin
        if txt_input = '0' then
            if col < A_col_1 then
                wait until clk'event and clk = '0';
                S(sig_store_S_row) <= sig_store_S_element;
                col := col + 1;
            else
                sig_is_S_generated <= '1';
                wait;
            end if;
        else
            if col < A_col_1 then
                wait until clk'event and clk = '0';
                S(sig_store_S_row_File) <= sig_store_S_element_File;
                col := col + 1;
            else
                sig_is_S_generated <= '1';
                wait;
            end if;
        end if;
    end process;

    generate_Matrix_S_FILE : generate_S_by_file
    port map(
        clk => clk,
        txt_input => txt_input,

        S_row => sig_store_S_row_File,
        S_out => sig_store_S_element_File,
        file_end => sig_is_S_file_end
    );
--======================= Matrix S =============================
 
--======================= Matrix E =============================
    generate_Matrix_E_LFSR : generate_e      
        port map(
            clk => clk,
            q => q,
            txt_input => txt_input,

            store_E_row => sig_store_E_row,
            store_E_ele => sig_store_E_element
        );
        
    store_E : process       
        variable row : integer := 0;
    begin
        if txt_input = '0' then
            if row < A_row_1 then
                wait until clk'event and clk = '0';
                E(sig_store_E_row) <= sig_store_E_element;
                row := row + 1;
            else
                sig_is_E_generated <= '1';
                wait;
            end if;
        else
            if row < A_row_1 then
                wait until clk'event and clk = '0';
                E(sig_store_E_row_File) <= sig_store_E_element_File;
                row := row + 1;
            else
                sig_is_E_generated <= '1';
                wait;
            end if;
        end if;
    end process;

    generate_Matrix_E_FILE : generate_E_by_file
    port map(
        clk => clk,
        txt_input => txt_input,

        E_row => sig_store_E_row_File,
        E_out => sig_store_E_element_File,
        file_end => sig_is_E_file_end
    );
--======================= Matrix E =============================
 
--======================= Matrix B =============================
    generate_Matrix_B : generate_B      
        port map(
            is_S_generated => sig_is_S_generated,
            is_A_generated => sig_is_A_generated,
            is_E_generated => sig_is_E_generated,

            clk => clk,
            q => q,
            multi_type => multi_type,
                        
            RowA_in => sig_RowA_in_B,
            Matrix_S => S,
            RowE_in => sig_RowE_in_B,
            
            store_B_row => sig_store_B_row,
            store_B_ele => sig_store_B_element
        );
        
    store_B : process       
        variable i : integer := 0;
        variable j : integer := 0;
    begin
        if (sig_is_A_generated = '1'      and sig_is_S_generated = '1'      and sig_is_E_generated = '1'      and sig_is_B_generated = '0') then
            if i < A_row_1 then
                if j < A_col_1 then
                    sig_RowA_in_B(j) <= A(i,j);
                    j := j + 1;
                else
                    sig_RowE_in_B <= E(i);
                    wait until clk'event and clk = '1';
                    B(sig_store_B_row) <= sig_store_B_element;
                    j := 0;
                    i := i + 1;
                end if;
            else
                sig_is_B_generated <= '1';
                wait;
            end if;
        else
            wait until clk'event and clk = '1';
        end if;
    end process;
--======================= Matrix B =============================
--============================== Set Up =============================

--================================ Generate n/4 random row number for 4 cahrs , set UV cells =============================
    UV_output : process         
        variable i : integer := 1;
        variable j : integer := 0;
    begin
        if sig_UV_output_generated = '1' then
            if i < (string_length + 1) then
                if j < ascii_length then
                    U_cells(i)(j, 0) <= sig_RowU_out_UV(0);
                    U_cells(i)(j, 1) <= sig_RowU_out_UV(1);
                    U_cells(i)(j, 2) <= sig_RowU_out_UV(2);
                    U_cells(i)(j, 3) <= sig_RowU_out_UV(3);
                    
                    V_cells(i,j) <= sig_RowV_out_UV;
                    j := j + 1;
                    wait until clk'event and clk='1';
                else
                    j := 0;
                    i := i + 1;
                end if;
            else
                wait until clk'event and clk='1';
            end if;
        else
            wait until clk'event and clk='1';
        end if;
        
        if sig_reset = '1' then
            i := 1;
            j := 0;
        end if;
    end process;
        
    UV_input : process          
        variable i : integer := 1;
        variable j : integer := 0;
        variable k : integer := 0;
    begin
        if sig_is_B_generated = '1' then
            if i < (string_length + 1) then
                if j < ascii_length then
                    if k < A_row_1 / 4 - 1 then
                        sig_RowA_in_UV(0) <= A(sig_random_row_num, 0);
                        sig_RowA_in_UV(1) <= A(sig_random_row_num, 1);
                        sig_RowA_in_UV(2) <= A(sig_random_row_num, 2);
                        sig_RowA_in_UV(3) <= A(sig_random_row_num, 3);
                               
                        sig_RowB_in_UV <= B(sig_random_row_num);
                        k := k + 1;
                    else
                        k := 0;
                        j := j + 1;
                    end if;
                else
                    j := 0;
                    i := i + 1;
                end if;
            else
                if sig_reset = '1' then
                    sig_is_UV_generated <= '0';
                    i := 1;
                    j := 0;
                    k := 0;
                else
                    sig_is_UV_generated <= '1';
                end if;
            end if;            
        end if;
        wait until clk'event and clk='0';
    end process;
    
    generate_Cells_UV : generate_UV             
        port map(
            is_B_generated => sig_is_B_generated,
            clk => clk,
            q => q,
            reset => sig_reset,
            ascii_bits_array => sig_ascii_array,
            RowA_in => sig_RowA_in_UV,
            RowB_in => sig_RowB_in_UV,

            random_row_num => sig_random_row_num,
            uv_row_num => sig_UV_row_num,

            output_generated => sig_UV_output_generated,
            RowU_out => sig_RowU_out_UV,
            RowV_out => sig_RowV_out_UV
        );
--================================ Generate n/4 random row number for 4 cahrs , set UV cells =============================

--======================= 3q/4 and q/4 round up =============================
    with (3*q mod 4) select
        three_quar_q <= (3*q/4) when 0,
                        (3*q - 1)/4 when 1,
                        (3*q + 2)/4 when 2,
                        (3*q + 1)/4 when others;

    with (q mod 4) select
        quar_q <= (q/4) when 0,
                    (q - 1)/4 when 1,
                    (q + 2)/4 when 2,
                    (q + 1)/4 when others;
--======================= 3q/4 and q/4 round up =============================

--=================== decryption to dec_ascii_array =====================
    decryption : process
        variable RowU_0, RowU_1, RowU_2, RowU_3 : integer := 0;
        variable RowV   : integer := 0;
        variable tmp   : integer := 0;
        
        variable i : integer := 1;
        variable j : integer := 0;
    begin
        if sig_is_UV_generated = '1' then        
            if i < (string_length + 1) then
                if j < ascii_length then
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
                    j := j + 1;
                else
                    j := 0;
                    i := i + 1;
                end if;
            else
                if sig_reset = '0' then
                    sig_is_dec_finished <= '1';
                else
                    sig_is_dec_finished <= '0';
                    sig_dec_ascii_array <= (others => (others => '0'));
                    i := 1;
                    j := 0;
                end if;
                wait until clk'event and clk='0';
            end if;
        else
            wait until clk'event and clk='0';
        end if;
    end process;
--=================== decryption to dec_ascii_array =====================
    
--================== final stage : convert ascii array to chars ===========================
    ascii_to_chars : ascii_array_to_chars
        port map(
            clk => clk,
            reset => sig_reset,
            sig_is_dec_generated => sig_is_dec_finished,
            ascii_array_in => sig_dec_ascii_array,
            
            decode_string => result,
            sig_result_release => sig_is_result_released
        );
--================== final stage : convert ascii array to chars ===========================
end Behavioral;