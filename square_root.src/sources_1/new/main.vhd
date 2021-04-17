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

entity main is
    generic (n: integer := 8);
    Port ( Clk: in STD_LOGIC;
           Rst: in STD_LOGIC;
           Start: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (n-1 downto 0);
           Q : out STD_LOGIC_VECTOR ((n/2 - 1) downto 0);
           R : out STD_LOGIC_VECTOR ((n/2 + 1) downto 0);
           Term: out STD_LOGIC);
end main;

architecture Behavioral of main is

signal ShiftD: STD_LOGIC;
signal ShiftQ: STD_LOGIC;
signal LoadD: STD_LOGIC;
signal LoadQ: STD_LOGIC;
signal LoadR: STD_LOGIC;
signal EnALU: STD_LOGIC;

signal in1: STD_LOGIC_VECTOR(n/2 + 1 downto 0);
signal in2: STD_LOGIC_VECTOR(n/2 + 3 downto 0);

signal BitNout: STD_LOGIC := '0';
signal outBist: STD_LOGIC;
signal LoadBist: STD_LOGIC;
signal BitNm1: STD_LOGIC := '0'; 

signal outD: STD_LOGIC_VECTOR(n-1 downto 0);
signal outQ: STD_LOGIC_VECTOR(n/2 -1 downto 0);
signal outR: STD_LOGIC_VECTOR(n/2 + 1 downto 0);
signal outALU: STD_LOGIC_VECTOR(n/2 + 1 downto 0);
signal notoutR: STD_LOGIC := '0';
signal initQ: STD_LOGIC_VECTOR(n/2 - 1 downto 0) := (others => '0');
signal initR: STD_LOGIC_VECTOR(n/2 + 1 downto 0):= (others => '0');

component FD is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           CE : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;


begin

notoutR <= not BitNout;
R <= outR;
Q <= outQ;

in1 <= outQ & outBist & '1';
in2 <= outR & outD(n-1 downto n-2);


DReg: entity WORK.SL2R generic map (n => n) port map(Clk, Rst, ShiftD, D, "00", LoadD, outD);
QReg: entity WORK.SL1R generic map (n => n) port map(Clk, Rst, ShiftQ, initQ, notoutR, LoadQ, outQ);
Rreg: entity WORK.FDN generic map (n => n) port map(Clk, Rst, LoadR, outALU, outR);
ALU:  entity WORK.ALU generic map (n => n) port map(Clk, EnAlu , in1, in2, outBist , BitNout, BitNm1, outALU);
Bist: FD port map(Clk, Rst, LoadBist, BitNout, outBist);
comenzi: entity WORK.comenzi generic map (n => n) port map(Clk ,Rst, Start, ShiftD, ShiftQ, LoadD, LoadQ, LoadR, LoadBist, EnALU, Term);


end Behavioral;