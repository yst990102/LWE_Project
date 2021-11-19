library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity ReadFileByChar is
    port(
        clk : in std_logic;
        string_out : out string(1 to 60)
    );
end ReadFileByChar;

architecture Behavioral of ReadFileByChar is
    file read_file : text;

    signal sig_string_out : string(1 to 60) := (others => NUL);
    signal is_file_end : std_logic := '0';
begin
    string_out <= sig_string_out;
    process
        variable tmp_line : Line;
        variable tmp_char : character;
    begin
        file_open(read_file, "E:\Github_repository\COMP3601\VHDL Work\3601_project_files\std_logic_vector\source\Sample.txt", read_mode);
        while not endfile(read_file) loop
            readline(read_file, tmp_line);
            for j in tmp_line'range loop
                read(tmp_line, tmp_char);
                sig_string_out(j) <= tmp_char;
            end loop;
            wait until clk'event and clk = '0';
            sig_string_out <= (others => NUL);
        end loop;
        is_file_end <= '1';

        file_close(read_file);
        wait;
    end process;
end Behavioral;