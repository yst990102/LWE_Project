library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package configuration_set is
    constant string_length : integer := 60;
    constant ascii_length : integer := 8;

    type ascii_array is array (1 to string_length) of std_logic_vector(0 to ascii_length - 1); 

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
    type RowA_1 is array (0 to A_col_1 - 1) of integer;

    type matrixS_1 is array (0 to A_col_1 - 1)       of integer;
    type matrixA_1 is array (0 to A_row_1 - 1)       of RowA_1;
    type matrixB_1 is array (0 to A_row_1 - 1)       of integer;
    type matrixE_1 is array (0 to A_row_1 - 1)       of integer;
    
----    ==== Configuration 02 Type
    type RowA_2 is array (0 to A_col_2 - 1) of integer;

    type matrixS_2 is array (0 to A_col_2 - 1)       of integer;
    type matrixA_2 is array (0 to A_row_2 - 1)       of RowA_2;
    type matrixB_2 is array (0 to A_row_2 - 1)       of integer;
    type matrixE_2 is array (0 to A_row_2 - 1)       of integer;
    
----    ==== Configuration 03 Type
    type RowA_3 is array (0 to A_col_3 - 1) of integer;

    type matrixS_3 is array (0 to A_col_3 - 1)       of integer;
    type matrixA_3 is array (0 to A_row_3 - 1)       of RowA_3;
    type matrixB_3 is array (0 to A_row_3 - 1)       of integer;
    type matrixE_3 is array (0 to A_row_3 - 1)       of integer;


----    ==== Configuration UV
    type RowU_1 is array (0 to A_col_1 - 1) of integer;
    type RowU_2 is array (0 to A_col_2 - 1) of integer;
    type RowU_3 is array (0 to A_col_3 - 1) of integer;

    type U_cell_1  is array (0 to ascii_length - 1) of RowU_1;
    type U_cell_2  is array (0 to ascii_length - 1) of RowU_2;
    type U_cell_3  is array (0 to ascii_length - 1) of RowU_3;

    type U_storage_1 is array (1 to string_length) of U_cell_1;
    type U_storage_2 is array (1 to string_length) of U_cell_2;
    type U_storage_3 is array (1 to string_length) of U_cell_3;
        
    type V_storage is array(1 to string_length, 0 to ascii_length - 1) of integer;

end configuration_set;