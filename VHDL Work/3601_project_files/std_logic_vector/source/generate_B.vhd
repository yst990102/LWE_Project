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
    
    constant sz : integer := 8;
    signal sig_x00, sig_x01, sig_x02, sig_x03 : std_logic_vector(sz-1 downto 0);
    signal sig_y00, sig_y01, sig_y02, sig_y03 : std_logic_vector(sz-1 downto 0);
    signal sig_m00, sig_m01, sig_m02, sig_m03 : std_logic_vector(2*sz-1 downto 0);
    
    signal row_stored : integer := 0;
    signal ele_stored : integer := 0;
begin
    approxim_multi00 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => sig_x00,
        Y => sig_y00,
        M => sig_m00
    );
    
    approxim_multi01 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => sig_x01,
        Y => sig_y01,
        M => sig_m01
    );
    approxim_multi02 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => sig_x02,
        Y => sig_y02,
        M => sig_m02
    );
    
    approxim_multi03 : dgn_MBMmul8bit
    generic map(sz => sz)
    port map(
        X => sig_x03,
        Y => sig_y03,
        M => sig_m03
    );


    process
        variable row_sum_accurate : integer := 0;
        variable row_sum_approxim : integer := 0;
        variable i : integer := 0;
    begin
        if is_S_generated = '1' and is_A_generated = '1' and is_E_generated = '1' then
            if i < A_row_1 then                
--                row_sum_accurate := RowA_in(0) * Matrix_S(0) + RowA_in(1) * Matrix_S(1) + RowA_in(2) * Matrix_S(2) + RowA_in(3) * Matrix_S(3);
                
                sig_x00 <= CONV_STD_LOGIC_VECTOR(RowA_in(0), sz); sig_x01 <= CONV_STD_LOGIC_VECTOR(RowA_in(1), sz); sig_x02 <= CONV_STD_LOGIC_VECTOR(RowA_in(2), sz); sig_x03 <= CONV_STD_LOGIC_VECTOR(RowA_in(3), sz);
                sig_y00 <= CONV_STD_LOGIC_VECTOR(Matrix_S(0), sz); sig_y01 <= CONV_STD_LOGIC_VECTOR(Matrix_S(1), sz); sig_y02 <= CONV_STD_LOGIC_VECTOR(Matrix_S(2), sz); sig_y03 <= CONV_STD_LOGIC_VECTOR(Matrix_S(3), sz);
                wait until clk'event and clk = '0';
                row_sum_approxim := CONV_INTEGER(sig_m00) + CONV_INTEGER(sig_m01) + CONV_INTEGER(sig_m02) + CONV_INTEGER(sig_m03);
                
                row_stored <= i;
                
                ele_stored <= (row_sum_accurate  + RowE_in)mod q;       --accurate sum
--                ele_stored <= (row_sum_approxim)mod q;       --accurate sum
                
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
