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

entity comenzi is
    generic(n : integer);
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Start : in STD_LOGIC;
           ShiftD: out STD_LOGIC;
           ShiftQ: out STD_LOGIC;
           LoadD: out STD_LOGIC;
           LoadQ: out STD_LOGIC;
           LoadR: out STD_LOGIC;
           LoadBist: out STD_LOGIC;
           EnALU: out STD_LOGIC;
           Term: out STD_LOGIC);
end comenzi;

architecture Behavioral of comenzi is

type states is (idle, init, operation, choice, shift, stop);
signal state: states := idle;
signal count : integer;
begin

process(state)
begin
case state is
    when idle => ShiftD <= '0'; ShiftQ <='0'; LoadD <='0'; LoadQ <= '0';  LoadR<='0'; EnALU <= '0'; LoadBist <= '0'; Term<='0'; 
    when init => ShiftD <= '0'; ShiftQ <='0'; LoadD <='1'; LoadQ <= '1';  LoadR<='0'; EnALU <= '0'; LoadBist <= '0'; Term<='0'; count <= n/2;
    when operation => ShiftD <= '0'; ShiftQ <='0'; LoadD <='0'; LoadQ <= '0';  LoadR<='0'; EnALU <= '1'; LoadBist <= '0'; Term<='0';
    when choice => ShiftD <= '0'; ShiftQ <='0'; LoadD <='0'; LoadQ <= '0';  LoadR<='1'; EnALU <= '0'; LoadBist <= '1'; Term<='0'; 
    when shift => ShiftD <= '1'; ShiftQ <='1'; LoadD <='0'; LoadQ <= '0';  LoadR<='1'; EnALU <= '0'; LoadBist <= '0'; Term<='0'; count <= count - 1;
    when stop => ShiftD <= '0'; ShiftQ <='0'; LoadD <='0'; LoadQ <= '0';  LoadR<='0'; EnALU <= '0'; LoadBist <= '0'; Term<='1'; 
end case;
end process;

process(clk)
begin
    if(rising_edge(clk)) then
        if (rst = '1') then 
            state <= idle;
        else
        case state is
            when idle =>    
                if (start = '1') then
                    state <= init;
                end if;
            when init =>
                state <= operation;
            when operation =>
                state <= choice;    
            when choice =>
                 if (count = 0) then 
                    state <= stop;                
                 else
                    state <= shift;    
                 end if;
            when shift =>
                    state <= operation;
             when stop =>
                    state <= idle;                       
         end case;
         end if;
       end if;                                         
end process;    
end Behavioral;
