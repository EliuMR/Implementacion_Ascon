library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Difusion_Lineal is
  Port (Estado: in bit_vector(0 to 319);
        EstadoDifusion: out bit_vector(0 to 319));
end Difusion_Lineal;

architecture Behavioral of Difusion_Lineal is
signal x0_1,x1_1,x2_1,x3_1,x4_1: bit_vector(0 to 63);
alias x0: bit_vector(0 to 63) is Estado(0 to 63);
alias x1: bit_vector(0 to 63) is Estado(64 to 127);
alias x2: bit_vector(0 to 63) is Estado(128 to 191);
alias x3: bit_vector(0 to 63) is Estado(192 to 255);
alias x4: bit_vector(0 to 63) is Estado(256 to 319);
begin

x0_1<=x0 xor (x0 ror 19) xor (x0 ror 28);
x1_1<=x1 xor (x1 ror 61) xor (x1 ror 39);
x2_1<=x2 xor (x2 ror 1 ) xor (x2 ror 6 );
x3_1<=x3 xor (x3 ror 10) xor (x3 ror 17);
x4_1<=x4 xor (x4 ror 7 ) xor (x4 ror 41);

EstadoDifusion<=x0_1&x1_1&x2_1&x3_1&x4_1;
end Behavioral;
