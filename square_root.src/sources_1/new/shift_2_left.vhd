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

entity SL2R is
    generic (n: integer);
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (n-1 downto 0);
           SRI : in STD_LOGIC_VECTOR(1 downto 0);
           Load : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (n-1 downto 0));
end SL2R;

architecture Behavioral of SL2R is
signal temp: std_logic_vector(n-1 downto 0);
begin

process(Clk)
begin
    if rising_edge(Clk) then
            if (Rst = '1') then 
            temp <= (others => '0');
        else 
            if(Load = '1') then
                temp <= D;
            else    
                if(CE = '1') then
                    temp <= temp(n-3 downto 0) & SRI;
                end if;    
            end if;
        end if;
    end if;
end process;  
 
Q <= temp; 

end Behavioral;
