library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_B is
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
end generate_B;

architecture Behavioral of generate_B is
    component dgn_MBMmul8bit is
        generic(sz : integer);
        port(
            X : in std_logic_vector(sz-1 downto 0);
            Y : in std_logic_vector(sz-1 downto 0);
            M : out std_logic_vector(2*sz-1 downto 0)
        );
    end component;

    component dgn_mitchellmul8bit is
        generic(sz : integer);
        port(
            X : in std_logic_vector(sz-1 downto 0);
            Y : in std_logic_vector(sz-1 downto 0);
            M : out std_logic_vector(2*sz-1 downto 0)
        );
    end component;

    component dgn_REALM8x8mul8bit is
        generic(sz : integer; m : integer);
        port(
            X : in std_logic_vector(sz-1 downto 0);
            Y : in std_logic_vector(sz-1 downto 0);
            MM : out std_logic_vector(2*sz-1 downto 0)
        );
    end component;
    
    constant sz : integer := 8;
    constant m : integer := 8;

    signal MBM_x_00, MBM_x_01, MBM_x_02, MBM_x_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal MBM_y_00, MBM_y_01, MBM_y_02, MBM_y_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal MBM_m_00, MBM_m_01, MBM_m_02, MBM_m_03 : std_logic_vector(2*sz-1 downto 0) := (others => '0');

    signal Mit_x_00, Mit_x_01, Mit_x_02, Mit_x_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal Mit_y_00, Mit_y_01, Mit_y_02, Mit_y_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal Mit_m_00, Mit_m_01, Mit_m_02, Mit_m_03 : std_logic_vector(2*sz-1 downto 0) := (others => '0');
    
    signal REALM_x_00, REALM_x_01, REALM_x_02, REALM_x_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal REALM_y_00, REALM_y_01, REALM_y_02, REALM_y_03 : std_logic_vector(sz-1 downto 0) := (others => '0');
    signal REALM_m_00, REALM_m_01, REALM_m_02, REALM_m_03 : std_logic_vector(2*sz-1 downto 0) := (others => '0');
    
    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
begin
    -- MBM multiplier 8 bits
    approxim_multi00 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => MBM_x_00,
        Y => MBM_y_00,
        M => MBM_m_00
    );
    
    approxim_multi01 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => MBM_x_01,
        Y => MBM_y_01,
        M => MBM_m_01
    );

    approxim_multi02 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => MBM_x_02,
        Y => MBM_y_02,
        M => MBM_m_02
    );
    
    approxim_multi03 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => MBM_x_03,
        Y => MBM_y_03,
        M => MBM_m_03
    );


    -- Mitchell multiplier 8 bits
    approxim_multi04 : dgn_mitchellmul8bit
    generic map(sz => sz)
    port map(
        X => Mit_x_00,
        Y => Mit_y_00,
        M => Mit_m_00
    );
    
    approxim_multi05 : dgn_mitchellmul8bit
    generic map(sz => sz)
    port map(
        X => Mit_x_01,
        Y => Mit_y_01,
        M => Mit_m_01
    );

    approxim_multi06 : dgn_mitchellmul8bit
    generic map(sz => sz)
    port map(
        X => Mit_x_02,
        Y => Mit_y_02,
        M => Mit_m_02
    );
    
    approxim_multi07 : dgn_mitchellmul8bit
    generic map(sz => sz)
    port map(
        X => Mit_x_03,
        Y => Mit_y_03,
        M => Mit_m_03
    );

    
    -- REALM multiplier 8 bits
    approxim_multi08 : dgn_REALM8x8mul8bit
    generic map(sz => sz, m => m)
    port map(
        X => REALM_x_00,
        Y => REALM_y_00,
        MM => REALM_m_00
    );
    
    approxim_multi09 : dgn_REALM8x8mul8bit
    generic map(sz => sz, m => m)
    port map(
        X => REALM_x_01,
        Y => REALM_y_01,
        MM => REALM_m_01
    );

    approxim_multi10 : dgn_REALM8x8mul8bit
    generic map(sz => sz, m => m)
    port map(
        X => REALM_x_02,
        Y => REALM_y_02,
        MM => REALM_m_02
    );
    
    approxim_multi11 : dgn_REALM8x8mul8bit
    generic map(sz => sz, m => m)
    port map(
        X => REALM_x_03,
        Y => REALM_y_03,
        MM => REALM_m_03
    );


    process
        variable row_sum_accurate : integer := 0;
        variable row_sum_approxim : integer := 0;
        variable i : integer := 0;
    begin
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            if i < A_row_1 then
                if multi_type = 1 then
                    -- accurate multiplier
                    row_sum_accurate := RowA_in(0) * Matrix_S(0) + RowA_in(1) * Matrix_S(1) + RowA_in(2) * Matrix_S(2) + RowA_in(3) * Matrix_S(3);
                elsif multi_type = 2 then
                    -- MBM multiplier
                    MBM_x_00 <= CONV_STD_LOGIC_VECTOR(RowA_in(0), sz);  MBM_x_01 <= CONV_STD_LOGIC_VECTOR(RowA_in(1), sz);  MBM_x_02 <= CONV_STD_LOGIC_VECTOR(RowA_in(2), sz);  MBM_x_03 <= CONV_STD_LOGIC_VECTOR(RowA_in(3), sz);
                    MBM_y_00 <= CONV_STD_LOGIC_VECTOR(Matrix_S(0), sz); MBM_y_01 <= CONV_STD_LOGIC_VECTOR(Matrix_S(1), sz); MBM_y_02 <= CONV_STD_LOGIC_VECTOR(Matrix_S(2), sz); MBM_y_03 <= CONV_STD_LOGIC_VECTOR(Matrix_S(3), sz);
                elsif multi_type = 3 then
                    -- Mit multiplier
                    Mit_x_00 <= CONV_STD_LOGIC_VECTOR(RowA_in(0), sz);  Mit_x_01 <= CONV_STD_LOGIC_VECTOR(RowA_in(1), sz);  Mit_x_02 <= CONV_STD_LOGIC_VECTOR(RowA_in(2), sz);  Mit_x_03 <= CONV_STD_LOGIC_VECTOR(RowA_in(3), sz);
                    Mit_y_00 <= CONV_STD_LOGIC_VECTOR(Matrix_S(0), sz); Mit_y_01 <= CONV_STD_LOGIC_VECTOR(Matrix_S(1), sz); Mit_y_02 <= CONV_STD_LOGIC_VECTOR(Matrix_S(2), sz); Mit_y_03 <= CONV_STD_LOGIC_VECTOR(Matrix_S(3), sz);
                else
                    -- REALM multiplier
                    REALM_x_00 <= CONV_STD_LOGIC_VECTOR(RowA_in(0), sz);  REALM_x_01 <= CONV_STD_LOGIC_VECTOR(RowA_in(1), sz);  REALM_x_02 <= CONV_STD_LOGIC_VECTOR(RowA_in(2), sz);  REALM_x_03 <= CONV_STD_LOGIC_VECTOR(RowA_in(3), sz);
                    REALM_y_00 <= CONV_STD_LOGIC_VECTOR(Matrix_S(0), sz); REALM_y_01 <= CONV_STD_LOGIC_VECTOR(Matrix_S(1), sz); REALM_y_02 <= CONV_STD_LOGIC_VECTOR(Matrix_S(2), sz); REALM_y_03 <= CONV_STD_LOGIC_VECTOR(Matrix_S(3), sz);
                end if;

                wait until clk'event and clk = '0';
                
                if multi_type = 2 then
                    -- MBM multiplier
                    row_sum_approxim := CONV_INTEGER(MBM_m_00) + CONV_INTEGER(MBM_m_01) + CONV_INTEGER(MBM_m_02) + CONV_INTEGER(MBM_m_03);
                elsif multi_type = 3 then
                    -- Mit multiplier
                    row_sum_approxim := CONV_INTEGER(Mit_m_00) + CONV_INTEGER(Mit_m_01) + CONV_INTEGER(Mit_m_02) + CONV_INTEGER(Mit_m_03);
                else
                    -- REALM multiplier
                    row_sum_approxim := CONV_INTEGER(REALM_m_00) + CONV_INTEGER(REALM_m_01) + CONV_INTEGER(REALM_m_02) + CONV_INTEGER(REALM_m_03);
                end if;

                row_stored <= i;
                
                if multi_type = 1 then
                    ele_stored <= (row_sum_accurate  + RowE_in)mod q;       --accurate sum
                else
                    ele_stored <= (row_sum_approxim)mod q;       --approximate sum
                end if;
                
                i := i + 1;
                row_sum_accurate := 0;
            else
                wait;
            end if;
        else
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    store_B_row <= row_stored;
    store_B_ele <= ele_stored;

end Behavioral;
