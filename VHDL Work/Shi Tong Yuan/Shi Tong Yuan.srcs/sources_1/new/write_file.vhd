library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library std;
use std.textio.all;

entity write_file is
end write_file;

architecture Behavioral of write_file is

type lutable is array (0 to 4, 0 to 2) of integer range 0 to 4000;
signal sample_array: lutable:=( (1000, 2000, 3000),
                        (4000, 3000, 2000),
                        (100, 200, 300),
                        (1,2,3),
                        (5,6,7));
begin

    process
        variable line_var : line;
        file text_var : text;
        
        variable write_int : integer;
        
    begin
        file_open(text_var,"E:\write.txt", append_mode);
        
        for y in lutable'range(1) loop
            for x in lutable'range(2) loop
                write_int := sample_array(y,x);
                write(line_var, integer'image(write_int));         -- write num into line_var
                writeline(text_var, line_var);   -- write line_var into the file
            end loop;
        end loop;
        
        
        file_close(text_var);
        wait;
    
    end process;


end Behavioral;
