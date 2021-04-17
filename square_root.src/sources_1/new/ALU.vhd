----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2020 09:36:54 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  generic (n: integer);
  Port (Clk : in STD_LOGIC;
        En: in STD_LOGIC;
        A : in STD_LOGIC_VECTOR((n/2 + 1) downto 0);
        B : in STD_LOGIC_VECTOR((n/2 + 3) downto 0);
        Sel : in STD_LOGIC;
        BitN: out STD_LOGIC;
        BitNm1: out STD_LOGIC; 
        Q: out STD_LOGIC_VECTOR((n/2 + 1) downto 0));
end ALU;

architecture Behavioral of ALU is
begin

process(Clk, EN)
variable temp : integer;
begin
    if(En = '1') then
        if(rising_edge(Clk)) then
            if (Sel = '0') then
                temp := to_integer(signed(B)) - to_integer(signed(A));
            else
                temp := to_integer(signed(A)) + to_integer(signed(B));
            end if;        
            
            if(temp < 0) then
                BitN <= '1'; --bitul de semn pt numere negative
                BitNm1 <= '0';
            else 
                BitN <= '0'; --bitul de semn
                BitNm1 <= '0'; --bitul de semn
            end if;
            
            Q <= std_logic_vector(to_signed(temp, Q'length));
        end if;
    end if;                    
end process;
end Behavioral;
