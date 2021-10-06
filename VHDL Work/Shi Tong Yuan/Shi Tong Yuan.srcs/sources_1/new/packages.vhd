library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package packages is
    constant q_min_1 : integer := 1;
    constant q_max_1 : integer := 128;
    constant q_min_2 : integer := 2048;
    constant q_max_2 : integer := 8192;
    constant q_min_3 : integer := 16384;
    constant q_max_3 : integer := 65535;
    
    constant A_row_1 : integer := 256;
    constant A_col_1 : integer := 4;
    constant A_row_2 : integer := 8192;
    constant A_col_2 : integer := 8;
    constant A_row_3 : integer := 32768;
    constant A_col_3 : integer := 16;
    
    constant e_min_1 : integer := -1;
    constant e_max_1 : integer := 1;
    constant e_min_2 : integer := -4;
    constant e_max_2 : integer := 4;
    constant e_min_3 : integer := -16;
    constant e_max_3 : integer := 16;

--    ==== Configuration 01 Type
    type matrixS_1 is array (0 to A_col_1 - 1,   0 to 1 - 1)       of integer range q_min_1 to q_max_1;
    type matrixA_1 is array (0 to A_row_1 - 1,   0 to A_col_1 - 1) of integer range q_min_1 to q_max_1;
    type matrixB_1 is array (0 to A_row_1 - 1,   0 to 1 - 1)       of integer range q_min_1 to q_max_1;
    type matrixE_1 is array (0 to A_row_1 - 1,   0 to 1 - 1)       of integer range e_min_1 to e_max_1;
    type matrixU_1 is array (0 to A_col_1 - 1,   0 to 1 - 1)       of integer range q_min_1 to q_max_1;
    
--    ==== Configuration 02 Type
    type matrixS_2 is array (0 to A_col_2 - 1,   0 to 1 - 1)       of integer range q_min_2 to q_max_2;
    type matrixA_2 is array (0 to A_row_2 - 1,   0 to A_col_2 - 1) of integer range q_min_2 to q_max_2;
    type matrixB_2 is array (0 to A_row_2 - 1,   0 to 1 - 1)       of integer range q_min_2 to q_max_2;
    type matrixE_2 is array (0 to A_row_2 - 1,   0 to 1 - 1)       of integer range e_min_2 to e_max_2;
    type matrixU_2 is array (0 to A_col_2 - 1,   0 to 1 - 1)       of integer range q_min_2 to q_max_2;
    
--    ==== Configuration 03 Type
    type matrixS_3 is array (0 to A_col_3 - 1,   0 to 1 - 1)       of integer range q_min_3 to q_max_3;
    type matrixA_3 is array (0 to A_row_3 - 1,   0 to A_col_3 - 1) of integer range q_min_3 to q_max_3;
    type matrixB_3 is array (0 to A_row_3 - 1,   0 to 1 - 1)       of integer range q_min_3 to q_max_3;
    type matrixE_3 is array (0 to A_row_3 - 1,   0 to 1 - 1)       of integer range e_min_3 to e_max_3;
    type matrixU_3 is array (0 to A_col_3 - 1,   0 to 1 - 1)       of integer range q_min_3 to q_max_3;
end packages;