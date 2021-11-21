library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity generate_A_by_file is
    port(
        clk : in std_logic;
        txt_input : in std_logic;

        A_row : out integer;
        A_out : out RowA_1;
        file_end : out std_logic
    );
end generate_A_by_file;

architecture Behavioral of generate_A_by_file is
    file read_file : text;

    signal sig_A_row : integer := 0;
    signal sig_A_out : RowA_1 := (others => 0);
    signal is_file_end : std_logic := '0';
begin
    A_row <= sig_A_row;
    A_out <= sig_A_out;
    file_end <= is_file_end;

    process is
        variable tmp_line : line;
        variable tmp_int_array : RowA_1 := (others => 0);
        variable str00, str01, str02, str03 : string(1 to 3) := (others => NUL);
        
        variable hun00, hun01, hun02, hun03 : integer := 0;
        variable ten00, ten01, ten02, ten03 : integer := 0;
        variable dig00, dig01, dig02, dig03 : integer := 0;
        
        variable row_num : integer := 0;

        variable space : character;
    begin
        if txt_input = '1' then
            file_open(read_file, "Matrix_A.txt", read_mode);
            while not endfile(read_file) loop
                readline(read_file, tmp_line);
                
                read(tmp_line, str00);
                
                case str00(1) is
                    when '1' => hun00 := 1;
                    when '2' => hun00 := 2;
                    when '3' => hun00 := 3;
                    when '4' => hun00 := 4;
                    when '5' => hun00 := 5;
                    when '6' => hun00 := 6;
                    when '7' => hun00 := 7;
                    when '8' => hun00 := 8;
                    when '9' => hun00 := 9;
                    when others => hun00 := 0;
                end case;

                case str00(2) is
                    when '1' => ten00 := 1;
                    when '2' => ten00 := 2;
                    when '3' => ten00 := 3;
                    when '4' => ten00 := 4;
                    when '5' => ten00 := 5;
                    when '6' => ten00 := 6;
                    when '7' => ten00 := 7;
                    when '8' => ten00 := 8;
                    when '9' => ten00 := 9;
                    when others => ten00 := 0;
                end case;

                case str00(3) is
                    when '1' => dig00 := 1;
                    when '2' => dig00 := 2;
                    when '3' => dig00 := 3;
                    when '4' => dig00 := 4;
                    when '5' => dig00 := 5;
                    when '6' => dig00 := 6;
                    when '7' => dig00 := 7;
                    when '8' => dig00 := 8;
                    when '9' => dig00 := 9;
                    when others => dig00 := 0;
                end case;

                sig_A_out(0) <= hun00 * 100 + ten00 * 10 + dig00 * 1;
                read(tmp_line, space);
                --   =========================================================

                read(tmp_line, str01);

                case str01(1) is
                    when '1' => hun01 := 1;
                    when '2' => hun01 := 2;
                    when '3' => hun01 := 3;
                    when '4' => hun01 := 4;
                    when '5' => hun01 := 5;
                    when '6' => hun01 := 6;
                    when '7' => hun01 := 7;
                    when '8' => hun01 := 8;
                    when '9' => hun01 := 9;
                    when others => hun01 := 0;
                end case;

                case str01(2) is
                    when '1' => ten01 := 1;
                    when '2' => ten01 := 2;
                    when '3' => ten01 := 3;
                    when '4' => ten01 := 4;
                    when '5' => ten01 := 5;
                    when '6' => ten01 := 6;
                    when '7' => ten01 := 7;
                    when '8' => ten01 := 8;
                    when '9' => ten01 := 9;
                    when others => ten01 := 0;
                end case;

                case str01(3) is
                    when '1' => dig01 := 1;
                    when '2' => dig01 := 2;
                    when '3' => dig01 := 3;
                    when '4' => dig01 := 4;
                    when '5' => dig01 := 5;
                    when '6' => dig01 := 6;
                    when '7' => dig01 := 7;
                    when '8' => dig01 := 8;
                    when '9' => dig01 := 9;
                    when others => dig01 := 0;
                end case;

                sig_A_out(1) <= hun01 * 100 + ten01 * 10 + dig01 * 1;
                read(tmp_line, space);
                
                --   =========================================================

                read(tmp_line, str02);

                case str02(1) is
                    when '1' => hun02 := 1;
                    when '2' => hun02 := 2;
                    when '3' => hun02 := 3;
                    when '4' => hun02 := 4;
                    when '5' => hun02 := 5;
                    when '6' => hun02 := 6;
                    when '7' => hun02 := 7;
                    when '8' => hun02 := 8;
                    when '9' => hun02 := 9;
                    when others => hun02 := 0;
                end case;

                case str02(2) is
                    when '1' => ten02 := 1;
                    when '2' => ten02 := 2;
                    when '3' => ten02 := 3;
                    when '4' => ten02 := 4;
                    when '5' => ten02 := 5;
                    when '6' => ten02 := 6;
                    when '7' => ten02 := 7;
                    when '8' => ten02 := 8;
                    when '9' => ten02 := 9;
                    when others => ten02 := 0;
                end case;

                case str02(3) is
                    when '1' => dig02 := 1;
                    when '2' => dig02 := 2;
                    when '3' => dig02 := 3;
                    when '4' => dig02 := 4;
                    when '5' => dig02 := 5;
                    when '6' => dig02 := 6;
                    when '7' => dig02 := 7;
                    when '8' => dig02 := 8;
                    when '9' => dig02 := 9;
                    when others => dig02 := 0;
                end case;

                sig_A_out(2) <= hun02 * 100 + ten02 * 10 + dig02 * 1;
                read(tmp_line, space);
                
                --   =========================================================

                read(tmp_line, str03);

                case str03(1) is
                    when '1' => hun03 := 1;
                    when '2' => hun03 := 2;
                    when '3' => hun03 := 3;
                    when '4' => hun03 := 4;
                    when '5' => hun03 := 5;
                    when '6' => hun03 := 6;
                    when '7' => hun03 := 7;
                    when '8' => hun03 := 8;
                    when '9' => hun03 := 9;
                    when others => hun03 := 0;
                end case;

                case str03(2) is
                    when '1' => ten03 := 1;
                    when '2' => ten03 := 2;
                    when '3' => ten03 := 3;
                    when '4' => ten03 := 4;
                    when '5' => ten03 := 5;
                    when '6' => ten03 := 6;
                    when '7' => ten03 := 7;
                    when '8' => ten03 := 8;
                    when '9' => ten03 := 9;
                    when others => ten03 := 0;
                end case;

                case str03(3) is
                    when '1' => dig03 := 1;
                    when '2' => dig03 := 2;
                    when '3' => dig03 := 3;
                    when '4' => dig03 := 4;
                    when '5' => dig03 := 5;
                    when '6' => dig03 := 6;
                    when '7' => dig03 := 7;
                    when '8' => dig03 := 8;
                    when '9' => dig03 := 9;
                    when others => dig03 := 0;
                end case;

                sig_A_out(3) <= hun03 * 100 + ten03 * 10 + dig03 * 1;

                sig_A_row <= row_num;
                row_num := row_num + 1;

                wait until clk'event and clk = '0';
            end loop;
            is_file_end <= '1';

            file_close(read_file);
            wait;
        else
            wait;
        end if;
    end process;

end Behavioral;