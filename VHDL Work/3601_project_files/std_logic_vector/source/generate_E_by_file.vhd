library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity generate_E_by_file is
    port(
        clk : in std_logic;
        E_out : out integer
    );
end generate_E_by_file;

architecture Behavioral of generate_E_by_file is
    file read_file : text;
    signal sig_E_out : integer := 0;
begin
    E_out <= sig_E_out;
    
    process is
        variable tmp_line : line;
        variable tmp_int_array : RowA_1 := (others => 0);
        variable str00, str01, str02, str03 : string(1 to 2) := (others => NUL);
        
        variable sig00, dig00 : integer := 0;        
        variable space : character;
    begin
        file_open(read_file, "E:\Github_repository\COMP3601\VHDL Work\3601_project_files\std_logic_vector\source\Matrix_E.txt", read_mode);
        while not endfile(read_file) loop
          readline(read_file, tmp_line);
          
          read(tmp_line, str00);
          
          case str00(1) is
            when '-' => sig00 := -1;
            when others => sig00 := 1;
          end case;

          case str00(2) is
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

          sig_E_out <= sig00 * dig00;
          
          wait until clk'event and clk = '1';
        end loop;

        file_close(read_file);
        wait;
    end process;

end Behavioral;