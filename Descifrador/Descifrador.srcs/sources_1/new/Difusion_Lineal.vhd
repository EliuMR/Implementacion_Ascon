library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity Difusion_Lineal is
  Port (Estado: in std_logic_vector (319 downto 0);
        EstadoDifusion: out std_logic_vector(319 downto 0));
end Difusion_Lineal;

architecture Behavioral of Difusion_Lineal is
signal x0_1,x1_1,x2_1,x3_1,x4_1: bit_vector(63 downto 0);
alias x0: std_logic_vector(63 downto 0) is Estado(63 downto 0);
alias x1: std_logic_vector(63 downto 0) is Estado(127 downto 64);
alias x2: std_logic_vector(63 downto 0) is Estado(191 downto 128);
alias x3: std_logic_vector(63 downto 0) is Estado(255 downto 192);
alias x4: std_logic_vector(63 downto 0) is Estado(319 downto 256);
signal x0p,x1p,x2p,x3p,x4p: bit_vector(63 downto 0);
begin
x0p<=to_bitvector(x0);
x1p<=to_bitvector(x1);
x2p<=to_bitvector(x2);
x3p<=to_bitvector(x3);
x4p<=to_bitvector(x4);
x0_1<=x0p xor (x0p ror 19) xor (x0p ror 28);
x1_1<=x1p xor (x1p ror 61) xor (x1p ror 39);
x2_1<=x2p xor (x2p ror 1 ) xor (x2p ror 6 );
x3_1<=x3p xor (x3p ror 10) xor (x3p ror 17);
x4_1<=x4p xor (x4p ror 7 ) xor (x4p ror 41);

EstadoDifusion<=to_stdlogicvector(x0_1&x1_1&x2_1&x3_1&x4_1);
end Behavioral;