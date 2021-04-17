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

entity FD is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
end FD;

architecture Behavioral of FD is
signal aux : STD_LOGIC;
begin

process(Rst, clk)
begin
    if (Rst = '1') then
        aux <= '0';
    else         
        if rising_edge(clk) then 
            if(CE = '1') then
                aux <= D;
            end if;
            if (CE = '0') then 
                aux <= aux;    
            end if;
        end if;
    end if;
    Q <= aux;
end process; 

end Behavioral;
