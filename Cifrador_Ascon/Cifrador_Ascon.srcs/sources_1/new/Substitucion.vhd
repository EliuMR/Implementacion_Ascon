library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Substitucion is
  Port (Estado: in std_logic_vector(319 downto 0);
        EstadoSubstitucion: out std_logic_vector(319 downto 0));
end Substitucion;

architecture Behavioral of Substitucion is
signal x0_1,x4_1,x2_1: std_logic_vector(63 downto 0);
signal t0,t1,t2,t3,t4: std_logic_vector(63 downto 0);
signal t0_1,t1_1,t2_1,t3_1,t4_1: std_logic_vector(63 downto 0);
signal t0_2,t1_2,t2_2,t3_2,t4_2: std_logic_vector(63 downto 0);
signal x0_2,x1_2,x2_2,x3_2,x4_2: std_logic_vector(63 downto 0);
signal x0_3,x1_3,x2_3,x3_3: std_logic_vector(63 downto 0);
alias x0: std_logic_vector(63 downto 0) is Estado(63 downto 0);
alias x1: std_logic_vector(63 downto 0) is Estado(127 downto 64);
alias x2: std_logic_vector(63 downto 0) is Estado(191 downto 128);
alias x3: std_logic_vector(63 downto 0) is Estado(255 downto 192);
alias x4: std_logic_vector(63 downto 0) is Estado(319 downto 256);
begin
x0_1<=x0 xor x4;
x2_1<=x2 xor x1;
x4_1<=x4 xor x3;

t0<=x0_1;
t1<=x1;
t2<=x2_1;
t3<=x3;
t4<=x4_1;

t0_1<=not t0;
t1_1<=not t1;
t2_1<=not t2;
t3_1<=not t3;
t4_1<=not t4;
 
t0_2<=t0_1 and x1;
t1_2<=t1_1 and x2_1;
t2_2<=t2_1 and x3;
t3_2<=t3_1 and x4_1;
t4_2<=t4_1 and x0;

x0_2<=x0_1 xor t1_2;
x1_2<=x1 xor t2_2;
x2_2<=x2_1 xor t3_2;
x3_2<=x3 xor t4_2;
x4_2<=x4_1 xor t0_2;

x1_3<=x1_2 xor x0_2;
x0_3<=x0_2 xor x4_2;
x3_3<=x3_2 xor x2_2;
x2_3<= not x2_2;

EstadoSubstitucion<=x0_3&x1_3&x2_3&x3_3&x4_2;
end Behavioral;