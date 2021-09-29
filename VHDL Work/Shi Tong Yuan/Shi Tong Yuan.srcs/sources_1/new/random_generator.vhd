LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

entity random_generator IS
    port(
--         q_min: in integer;
--         q_max: in integer;
         q:     out integer);
end random_generator;

architecture arch OF random_generator IS
    signal int_rand: INTEGER;
    
    signal q_min : integer := 2048;
    signal q_max : integer := 8192;
begin
    process
        variable seed1, seed2: POSITIVE;--修改种子可以得到不同的伪随机序列
        variable rand: REAL;
    begin
        for i in 0 to 9 loop
            UNIFORM(seed1, seed2, rand);
            int_rand <= INTEGER(trunc(rand*(real(q_max - q_min))));
            wait for 50 ps;
        end loop;
    end process;
    
    
end arch; 