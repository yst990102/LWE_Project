library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use std.textio.all;
use work.configuration_set.all;

entity Processor_TB is
end Processor_TB;

architecture Behavioral of Processor_TB is
    component Processor is
        port (
            encode_string   : in string(1 to string_length);
            clk             : in std_logic;
            sig_reset       : in std_logic;
            txt_input       : in std_logic;
            multi_type      : in integer;
            q_in            : in integer;
    
            result          : out string(1 to string_length);
            is_result_released : out std_logic
        );
    end component;
    
    constant clk_period : time := 20ps;
    
    signal clk : std_logic := '0';
    signal final_result : string(1 to string_length) := (others => NUL);

    signal test_string : string(1 to string_length) := "AbcD";
    -- signal test_string : string(1 to string_length) := (others => NUL);
    
    signal reset : std_logic := '0';

    signal is_file_end : std_logic := '0';
begin

    clk_generate : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process; 
    
    UUT : Processor
        port map(
            encode_string => test_string,
            clk => clk,
            sig_reset => reset,
            txt_input => '0',
            multi_type => 1,        -- 1:accurate, 2:MBM, 3:Mit, 4:REALM
            q_in => 27,
            result => final_result
        );

    -- main_testing : process
    --     file read_file : text;
    --     variable tmp_line : Line;
    --     variable tmp_char : character;
    -- begin
    --     file_open(read_file, "measure.txt", read_mode);
    --     while not endfile(read_file) loop
    --         readline(read_file, tmp_line);
    --         for j in tmp_line'range loop
    --             read(tmp_line, tmp_char);
    --             test_string(j) <= tmp_char;
    --         end loop;
    --         wait for 700 ns;
    --         test_string <= (others => NUL);
    --     end loop;
    --     is_file_end <= '1';

    --     file_close(read_file);
    --     wait;
    -- end process;

    -- main_testing : process
    --     file read_file : text;
    --     variable tmp_line : Line;
    --     variable tmp_char : character;
    -- begin
    --     file_open(read_file, "E:\Github_repository\COMP3601\VHDL Work\3601_project_files\std_logic_vector\source\Sample.txt", read_mode);
    --     while not endfile(read_file) loop
    --         readline(read_file, tmp_line);
    --         for j in tmp_line'range loop
    --             read(tmp_line, tmp_char);
    --             test_string(j) <= tmp_char;
    --         end loop;
    --         wait for 700 ns;
    --         test_string <= (others => NUL);
    --     end loop;
    --     is_file_end <= '1';

    --     file_close(read_file);
    --     wait;
    -- end process;

    -- reset_process : process
    -- begin
    --     wait for 700 ns;
    --     reset <= '1';
    --     wait for clk_period * 2;
    --     reset <= '0';

    -- end process;

    main_testing : process
    begin
        wait for 100 ns;
        test_string <= "DcbA";
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        wait for 100 ns;
        test_string <= "EfgH";
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        wait for 2 sec;
    end process;

end Behavioral;
