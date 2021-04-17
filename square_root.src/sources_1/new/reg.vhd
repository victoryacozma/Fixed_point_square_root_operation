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

entity FDN is
    generic(n : integer);
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR ((n/2 + 1) downto 0);
           Q : out STD_LOGIC_VECTOR ((n/2 + 1) downto 0));
end FDN;

architecture Behavioral of FDN is
begin
process(clk)
begin
    if rising_edge(clk) then
        if (Rst = '1') then 
            Q <= (others => '0');
        else 
            if(CE = '1') then
                Q <= D;
            end if;
            if(CE = '0') then
                Q <= (others => '0');
            end if;
        end if;
    end if;
end process;            
end Behavioral;
