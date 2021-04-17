library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Testbench is

end Testbench;

architecture Behavioral of Testbench is

signal Clk : std_logic := '0';
signal Rst : std_logic := '0';
signal Start : std_logic := '0';
signal D : std_logic_vector(7 downto 0) := (others => '0');
signal Q : std_logic_vector(3 downto 0) := (others => '0');
signal R : std_logic_vector(5 downto 0) := (others => '0');
signal Term : std_logic;

constant clk_period : time := 20 ns;
begin

process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;
 
radacina: entity WORK.main port map (Clk, Rst, Start, D, Q, R, Term);

process
begin		
      wait for 20 ns;	
		rst <= '1';
		wait for 20 ns;
		rst <= '0';
		wait for 20 ns;
        D <= "10001100";
        --D <= "01111001";
		start <= '1';
		wait for 20 ns;
        wait for 200 ns;
        wait for 200 ns;
      wait;
end process;
end Behavioral;
