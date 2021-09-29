library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity isprime is
    port(a:in integer;
         y:out std_logic);
end isprime;

architecture arch of isprime is
begin
    process(a)
        variable temp:integer;
        variable z:std_logic;
    begin
        temp:=a;
        z:='1';
        if(temp=1 or temp =0)then
            z:='0';
        elsif(temp>2)then
            for i in 2 to temp-1 loop
                if(temp mod i=0)then
                    z:='0';
                    exit;
                end if;
            end loop;
        end if;
        
        y<=z;
    end process;
end arch;