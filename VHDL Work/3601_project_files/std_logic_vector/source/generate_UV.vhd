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
        A_row               : in integer;
        A_col               : in integer;
        ascii_bits_array    : in ascii_array;
        RowA_in             : in RowA_3;
        RowB_in             : in integer;
        
        random_row_num      : out integer;
        uv_row_num          : out integer;
        output_generated    : out std_logic;
        RowU_out            : out RowU_3;
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
    signal row_num : integer := 0;
    signal is_output_generated : std_logic := '0';
    signal output_U : RowU_3 := (others => 0);
    signal output_V : integer := 0;
    
    signal half_q : integer := 0;
begin
    random_row_num <= row_num_random_result;
    uv_row_num <= row_num;
    output_generated <= is_output_generated;
    RowU_out <= output_U;
    RowV_out <= output_V;
    
    with q mod 2 select
        half_q <= q / 2 when 0,
                  (q + 1) / 2 when others;
    
    random_number: random_generator
        generic map (data_width => 15 )
        port map(
            seed => 220,
            reset => '1',
            clk => clk,
            data_out => row_num_random_result
        );
        
    generate_random_rows : process
        variable encoding_ascii : std_logic_vector(0 to ascii_length - 1);

        variable sum_U00, sum_U01, sum_U02, sum_U03 : integer;
        variable sum_U04, sum_U05, sum_U06, sum_U07 : integer;
        variable sum_U08, sum_U09, sum_U10, sum_U11 : integer;
        variable sum_U12, sum_U13, sum_U14, sum_U15 : integer;

        variable sum_V : integer;
        
        variable row : integer := 1;
        variable skip_1 : std_logic := '0';
        variable i : integer := 0;
        variable skip_2 : std_logic := '0';
        variable col : integer := 0;
    begin        
        if is_B_generated = '1' then
            if row < (string_length + 1) then
                if skip_1 = '0' then
                    encoding_ascii := ascii_bits_array(row);
                    skip_1 := '1';
                end if;

                if i < ascii_length then
                    if skip_2 = '0' then
                        row_num <= i;
                        
                        sum_U00 := 0; sum_U01 := 0; sum_U02 := 0; sum_U03 := 0;
                        sum_U04 := 0; sum_U05 := 0; sum_U06 := 0; sum_U07 := 0;
                        sum_U08 := 0; sum_U09 := 0; sum_U10 := 0; sum_U11 := 0;
                        sum_U12 := 0; sum_U13 := 0; sum_U14 := 0; sum_U15 := 0;

                        sum_V := 0;
                        skip_2 := '1';
                    end if;
                    
                    if col < A_row / 4 then
                        sum_U00 := sum_U00 + RowA_in(0);    sum_U01 := sum_U01 + RowA_in(1);    sum_U02 := sum_U02 + RowA_in(2);    sum_U03 := sum_U03 + RowA_in(3);
                        sum_U04 := sum_U04 + RowA_in(4);    sum_U05 := sum_U05 + RowA_in(5);    sum_U06 := sum_U06 + RowA_in(6);    sum_U07 := sum_U07 + RowA_in(7);
                        sum_U08 := sum_U08 + RowA_in(8);    sum_U09 := sum_U09 + RowA_in(9);    sum_U10 := sum_U10 + RowA_in(9);    sum_U11 := sum_U11 + RowA_in(11);
                        sum_U12 := sum_U12 + RowA_in(12);   sum_U13 := sum_U13 + RowA_in(13);   sum_U14 := sum_U14 + RowA_in(13);   sum_U15 := sum_U15 + RowA_in(15);                        
                        
                        sum_V := sum_V + RowB_in;
                        wait until clk'event and clk = '0';
                        is_output_generated <= '0';
                        
                        col := col + 1;
                    else
                        output_U(0) <= sum_U00 mod q;   output_U(1) <= sum_U01 mod q;   output_U(2) <= sum_U02 mod q;   output_U(3) <= sum_U03 mod q;
                        output_U(4) <= sum_U04 mod q;   output_U(5) <= sum_U05 mod q;   output_U(6) <= sum_U06 mod q;   output_U(7) <= sum_U07 mod q;
                        output_U(8) <= sum_U08 mod q;   output_U(9) <= sum_U09 mod q;   output_U(10) <= sum_U10 mod q;  output_U(11) <= sum_U11 mod q;
                        output_U(12) <= sum_U12 mod q;  output_U(13) <= sum_U13 mod q;  output_U(14) <= sum_U14 mod q;  output_U(15) <= sum_U15 mod q;
                        
                        if encoding_ascii(i) = '0' then
                            output_V <= (sum_V ) mod q;
                        else
                            output_V <= (sum_V - half_q) mod q;
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
                wait;
            end if;
        else
            wait until clk'event and clk = '0';
        end if;
    end process;
    
    

end Behavioral;
