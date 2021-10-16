library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package configuration_set is
    type ascii_array is array (1 to 4) of std_logic_vector(0 to 7); 

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
    type matrixS_1 is array (0 to A_col_1 - 1)       of integer;
    type matrixA_1 is array (0 to A_row_1 - 1,   0 to A_col_1 - 1) of integer;
    type matrixB_1 is array (0 to A_row_1 - 1)       of integer;
    type matrixE_1 is array (0 to A_row_1 - 1)       of integer;
    
    type RowA_1 is array (0 to A_col_1 - 1) of integer;
    
----    ==== Configuration 02 Type
    type matrixS_2 is array (0 to A_col_2 - 1)       of integer;
    type matrixA_2 is array (0 to A_row_2 - 1,   0 to A_col_2 - 1) of integer;
    type matrixB_2 is array (0 to A_row_2 - 1)       of integer;
    type matrixE_2 is array (0 to A_row_2 - 1)       of integer;
    
----    ==== Configuration 03 Type
    type matrixS_3 is array (0 to A_col_3 - 1)       of integer;
    type matrixA_3 is array (0 to A_row_3 - 1,   0 to A_col_3 - 1) of integer;
    type matrixB_3 is array (0 to A_row_3 - 1)       of integer;
    type matrixE_3 is array (0 to A_row_3 - 1)       of integer;

    type U_cell is array (0 to 7, 0 to A_col_1 - 1) of integer;
    type U_storage is array (1 to 4) of U_cell;
    
    type RowU_1 is array (0 to A_col_1 - 1) of integer;
        
    type V_storage is array(1 to 4,0 to 7) of integer;

end configuration_set;