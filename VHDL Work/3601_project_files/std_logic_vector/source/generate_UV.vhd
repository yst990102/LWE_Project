library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.configuration_set.all;

entity generate_UV is
    port (
        is_chars_loaded     : in std_logic;
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
    signal sig_uv_row_num : integer := 0;
    signal is_output_generated : std_logic := '0';
    signal output_U : RowU_1 := (others => 0);
    signal output_V : integer := 0;
    
    signal half_q : integer := 0;
begin
    random_row_num <= row_num_random_result;
    uv_row_num <= sig_uv_row_num;
    output_generated <= is_output_generated;
    RowU_out <= output_U;
    RowV_out <= output_V;
    
    with q mod 2 select
        half_q <= q / 2 when 0,
                  (q + 1) / 2 when others;
    
    random_number: random_generator
        generic map (data_width => 8 )
        port map(
            seed => 220,
            reset => '1',
            clk => clk,
            data_out => row_num_random_result
        );
        
    generate_random_rows : process
        variable encoding_ascii : std_logic_vector(0 to 7);
        variable first_ele, second_ele, third_ele, forth_ele : integer;
        variable first_sum, second_sum, third_sum, forth_sum, fifth_sum : integer;
        
        variable row : integer := 1;
        variable skip_1 : std_logic := '0';
        variable i : integer := 0;
        variable skip_2 : std_logic := '0';
        variable col : integer := 0;
        
    begin
        if is_B_generated = '1' and is_chars_loaded = '1' then
        
            if row < (string_length + 1) then
                if skip_1 = '0' then
                    encoding_ascii := ascii_bits_array(row);
                    skip_1 := '1';
                end if;

                if i < ascii_length then
                    if skip_2 = '0' then
                        sig_uv_row_num <= i;
                        
                        first_sum := 0;
                        second_sum := 0;
                        third_sum := 0;
                        forth_sum := 0;
                        fifth_sum := 0;
                        skip_2 := '1';
                    end if;
                    
                    if col < A_row_1 / 4 then
                        first_sum := first_sum + RowA_in(0);
                        second_sum := second_sum + RowA_in(1);
                        third_sum := third_sum + RowA_in(2);
                        forth_sum := forth_sum + RowA_in(3);
                        fifth_sum := fifth_sum + RowB_in;
                        wait until clk'event and clk = '0';
                        is_output_generated <= '0';
                        
                        col := col + 1;
                    else
                        output_U(0) <= first_sum mod q;
                        output_U(1) <= second_sum mod q;
                        output_U(2) <= third_sum mod q;
                        output_U(3) <= forth_sum mod q;
                        
                        if encoding_ascii(i) = '0' then
                            output_V <= (fifth_sum ) mod q;
                        else
                            output_V <= (fifth_sum - half_q) mod q;
                        end if;
                        is_output_generated <= '1';
                    
                        col := 0;
                        i := i + 1;
                        skip_2 := '0';
                    end if;
                else
                    i := 0;
                    skip_1 := '0';
                    row := row + 1;
                end if;
            else
                wait until clk'event and clk = '0';
            end if;
        else
            if reset = '1' then
                row := 1;
                skip_1 := '0';
                i := 0;
                skip_2 := '0';
                col := 0;
                is_output_generated <= '0';
                output_U <= (others => 0);
                output_V <= 0;
            end if;
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    

end Behavioral;
