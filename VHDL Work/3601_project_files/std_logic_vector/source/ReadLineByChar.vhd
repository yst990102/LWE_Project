library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity ReadLineByChar is
    port(
        clk : in std_logic;
        txt_input : in std_logic;

        char_out : out character;
        file_end : out std_logic
    );
end ReadLineByChar;

architecture Behavioral of ReadLineByChar is
    file read_file : text;

    signal sig_char_out : character;
    signal is_file_end : std_logic := '0';
begin

    process is
        variable tmp_line : line;
    begin
        if txt_input = '1' then
            file_open(read_file, "EncodedString.txt", read_mode);
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
        else
            wait;
        end if;
    end process;

end Behavioral;