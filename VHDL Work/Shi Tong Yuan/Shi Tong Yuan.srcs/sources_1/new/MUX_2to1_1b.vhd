----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2021 12:51:10
-- Design Name: 
-- Module Name: MUX_2to1_1b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_2to1_1b is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           sel : in STD_LOGIC;
           output : out STD_LOGIC);
end MUX_2to1_1b;

architecture Behavioral of MUX_2to1_1b is

begin

    output <= (NOT(sel) AND A) OR (sel AND B);

end Behavioral;
