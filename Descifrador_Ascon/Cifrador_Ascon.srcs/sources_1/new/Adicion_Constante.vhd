library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity Adicion_Constante is
  Port (Estado: in std_logic_vector(319 downto 0);
        Ronda: in std_logic;
        Contador: in std_logic_vector(3 downto 0);
        EstadoSuma: out std_logic_vector(319 downto 0));
end Adicion_Constante;

architecture Behavioral of Adicion_Constante is
signal P12_0,P12_1,P12_2,P12_3,P12_4,P12_5,P12_6,P12_7,P12_8,P12_9,P12_10,P12_11: std_logic_vector(7 downto 0); 
--signal P8_0,P8_1,P8_2,P8_3,P8_4,P8_5,P8_6,P8_7: bit_vector(0 to 7);
signal P6_0,P6_1,P6_2,P6_3,P6_4,P6_5: std_logic_vector(7 downto 0);
--signal x0,x1,x2,x3,x4: bit_vector(0 to 63);
signal selector: std_logic_vector(4 downto 0);
signal padding:std_logic_vector(55 downto 0);

alias x0: std_logic_vector(63 downto 0) is Estado(63 downto 0);
alias x1: std_logic_vector(63 downto 0) is Estado(127 downto 64);
alias x2: std_logic_vector(63 downto 0) is Estado(191 downto 128);
alias x3: std_logic_vector(63 downto 0) is Estado(255 downto 192);
alias x4: std_logic_vector(63 downto 0) is Estado(319 downto 256);

signal x2p: std_logic_vector(63 downto 0);

begin
--Constantes
P12_0<="11110000";
P12_1<="11100001";
P12_2<="11010010";
P12_3<="11000011";
P12_4<="10110100";
P12_5<="10100101";
P12_6<="10010110";
P12_7<="10000111";
P12_8<="01111000";
P12_9<="01101001";
P12_10<="01011010";
P12_11<="01001011";
--P8_0<="10110100";P8_1<="10100101";P8_2<="10010110";P8_3<="10000111";P8_4<="01111000";P8_5<="01101001";P8_6<="01011010";P8_7<="01001011";
P6_0<="10010110";
P6_1<="10000111";
P6_2<="01111000";
P6_3<="01101001";
P6_4<="01011010";
P6_5<="01001011";

padding<="00000000000000000000000000000000000000000000000000000000";
selector<=Ronda&Contador;
with selector select x2p <=
	(x2 xor padding&P12_0) when "00000",
	(x2 xor padding&P12_1) when "00001",
	(x2 xor padding&P12_2) when "00010",
	(x2 xor padding&P12_3) when "00011",
	(x2 xor padding&P12_4) when "00100",
	(x2 xor padding&P12_5) when "00101",
	(x2 xor padding&P12_6) when "00110",
	(x2 xor padding&P12_7) when "00111",
	(x2 xor padding&P12_8) when "01000",
	(x2 xor padding&P12_9) when "01001",
	(x2 xor padding&P12_10) when "01010",
	(x2 xor padding&P12_11) when "01011",
	(x2 xor padding&P6_0) when "10000",
	(x2 xor padding&P6_1) when "10001",
	(x2 xor padding&P6_2) when "10010",
	(x2 xor padding&P6_3) when "10011",
	(x2 xor padding&P6_4) when "10100",
	(x2 xor padding&P6_5) when others;
EstadoSuma<=x0&x1&x2p&x3&x4;
end Behavioral;