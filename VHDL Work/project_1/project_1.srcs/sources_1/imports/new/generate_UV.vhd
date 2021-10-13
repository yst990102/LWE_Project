library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_UV is
    port (
        is_B_generated      : in std_logic;
        clk                 : in std_logic;
        q                   : in integer;
        ascii_bits_array    : in ascii_array;
        RowA_in             : in RowA_1;
        RowB_in             : in integer;
--        Matrix_A            : in matrixA_1;
--        Matrix_B            : in matrixB_1;
        
        random_row_num      : out integer;
        uv_row_num          : out integer;
--        U_cells             : out U_storage;
--        V_cells             : out V_storage;
        RowU_out            : out RowU_1;
        RowV_out            : out integer
--        is_UV_generated      : out std_logic
    );
end generate_UV;

architecture Behavioral of generate_UV is
    component random_generator is
        generic (data_width : natural);
        port(
            seed : in integer;
            reset : in std_logic;
            clk : in std_logic;
            data_out : out integer);
    end component;
    
    signal row_num_random_result : integer := 0;
    
    signal sig_first_sum : integer := 0;
    signal sig_second_sum : integer := 0;
    signal sig_third_sum : integer := 0;
    signal sig_forth_sum : integer := 0;
    signal sig_fifth_sum : integer := 0;
begin
    random_row_num <= row_num_random_result;
    
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
        if is_B_generated = '1' then
            for row in 1 to 4 loop
                encoding_ascii := ascii_bits_array(row);

                for i in encoding_ascii'range(1) loop
                    uv_row_num <= i;
                    
                    first_sum := 0;
                    second_sum := 0;
                    third_sum := 0;
                    forth_sum := 0;
                    fifth_sum := 0;
                    
                    sig_first_sum <= 0;
                    sig_second_sum <= 0;
                    sig_third_sum <= 0;
                    sig_forth_sum <= 0;
                    sig_fifth_sum <= 0;
                    
                    for col in 0 to (A_row_1 / 4 - 1) loop
--                        first_sum := first_sum + Matrix_A(row_num_random_result, 0);
--                        second_sum := second_sum + Matrix_A(row_num_random_result, 1);
--                        third_sum := third_sum + Matrix_A(row_num_random_result, 2);
--                        forth_sum := forth_sum + Matrix_A(row_num_random_result, 3);
--                        fifth_sum := fifth_sum + Matrix_B(row_num_random_result);
                        
                        first_sum := first_sum + RowA_in(0);
                        second_sum := second_sum + RowA_in(1);
                        third_sum := third_sum + RowA_in(2);
                        forth_sum := forth_sum + RowA_in(3);
                        fifth_sum := fifth_sum + RowB_in;
                        
                        sig_first_sum <= first_sum;
                        sig_second_sum <= second_sum;
                        sig_third_sum <= third_sum;
                        sig_forth_sum <= forth_sum;
                        sig_fifth_sum <= fifth_sum;

--                        wait for 20ps;
                        wait until clk'event and clk = '0';
                    end loop;
                    
--                    U_cells(row)(i,0) <= first_sum mod q;
--                    U_cells(row)(i,1) <= second_sum mod q;
--                    U_cells(row)(i,2) <= third_sum mod q;
--                    U_cells(row)(i,3) <= forth_sum mod q;
                    
--                    V_cells(row, i) <= (fifth_sum - (q/2) * i) mod q;

                    RowU_out(0) <=  first_sum mod q;
                    RowU_out(1) <= second_sum mod q;
                    RowU_out(2) <= third_sum mod q;
                    RowU_out(3) <= forth_sum mod q;
                    
                    RowV_out <= (fifth_sum - (q/2) * i) mod q;
                end loop;
                
            end loop;
--            is_UV_generated <= '1';
            wait;
        else
--            wait for 20ps;
            wait until clk'event and clk = '0';
        end if;
    end process;

end Behavioral;
