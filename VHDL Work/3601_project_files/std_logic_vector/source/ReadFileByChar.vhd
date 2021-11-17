library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity ReadFileByChar is
    port(
        clk : in std_logic;
        char_out : out character
    );
end ReadFileByChar;

architecture Behavioral of ReadFileByChar is
    file read_file : text;

    signal sig_char_out : character;
    signal is_file_end : std_logic := '0';
begin
    char_out <= sig_char_out;
    process
        variable tmp_line : Line;
    begin
        file_open(read_file, "E:\Github_repository\COMP3601\VHDL Work\3601_project_files\std_logic_vector\source\Sample.txt", read_mode);
        while not endfile(read_file) loop
            readline(read_file, tmp_line);
            for j in tmp_line'range loop
                sig_char_out <= tmp_line(j);
                wait until clk'event and clk = '0';
            end loop;
        end loop;
        is_file_end <= '1';

        file_close(read_file);
        wait;
    end process;
end Behavioral;