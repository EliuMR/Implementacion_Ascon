library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Bloque_Permutacion_Rondas is
  Port (R:in std_logic_vector(63 downto 0);
        C:in std_logic_vector(255 downto 0);
        Ronda:in std_logic;
        S:out std_logic_vector(319 downto 0));
end Bloque_Permutacion_Rondas;


architecture Behavioral of Bloque_Permutacion_Rondas is
component Permutacion is
  Port (R:in std_logic_vector(63 downto 0);
        C:in std_logic_vector(255 downto 0);
        Ronda_A_B: in std_logic;
        Contador_Ronda: in std_logic_vector(3 downto 0);
        Sr:out std_logic_vector(63 downto 0);
        Sc:out std_logic_vector(255 downto 0));
end component;

--component  RondaA is
--    Port ( reset,clock : in std_logic;
--           salida: out std_logic_vector(0 to 3));
--end component;

--component RondaB is
--    Port ( reset,clock : in std_logic;
--           salida: out std_logic_vector(0 to 3));
--end component;
--ronda A
signal ar_p0,ar_p1,ar_p2,ar_p3,ar_p4,ar_p5,ar_p6,ar_p7,ar_p8,ar_p9,ar_p10,ar_p11: std_logic_vector(63 downto 0);
signal ac_p0,ac_p1,ac_p2,ac_p3,ac_p4,ac_p5,ac_p6,ac_p7,ac_p8,ac_p9,ac_p10,ac_p11: std_logic_vector(255 downto 0);
--ronda B
signal br_p0,br_p1,br_p2,br_p3,br_p4,br_p5: std_logic_vector(63 downto 0);
signal bc_p0,bc_p1,bc_p2,bc_p3,bc_p4,bc_p5: std_logic_vector(255 downto 0);

begin
A1: Permutacion port map(R=>R,C=>C,Ronda_A_B=>'0',Contador_Ronda=>"0000",Sr=>ar_p0,Sc=>ac_p0);
A2: Permutacion port map(R=>ar_p0,C=>ac_p0,Ronda_A_B=>'0',Contador_Ronda=>"0001",Sr=>ar_p1,Sc=>ac_p1);
A3: Permutacion port map(R=>ar_p1,C=>ac_p1,Ronda_A_B=>'0',Contador_Ronda=>"0010",Sr=>ar_p2,Sc=>ac_p2);
A4: Permutacion port map(R=>ar_p2,C=>ac_p2,Ronda_A_B=>'0',Contador_Ronda=>"0011",Sr=>ar_p3,Sc=>ac_p3);
A5: Permutacion port map(R=>ar_p3,C=>ac_p3,Ronda_A_B=>'0',Contador_Ronda=>"0100",Sr=>ar_p4,Sc=>ac_p4);
A6: Permutacion port map(R=>ar_p4,C=>ac_p4,Ronda_A_B=>'0',Contador_Ronda=>"0101",Sr=>ar_p5,Sc=>ac_p5);
A7: Permutacion port map(R=>ar_p5,C=>ac_p5,Ronda_A_B=>'0',Contador_Ronda=>"0110",Sr=>ar_p6,Sc=>ac_p6);
A8: Permutacion port map(R=>ar_p6,C=>ac_p6,Ronda_A_B=>'0',Contador_Ronda=>"0111",Sr=>ar_p7,Sc=>ac_p7);
A9: Permutacion port map(R=>ar_p7,C=>ac_p7,Ronda_A_B=>'0',Contador_Ronda=>"1000",Sr=>ar_p8,Sc=>ac_p8);
A10:Permutacion port map(R=>ar_p8,C=>ac_p8,Ronda_A_B=>'0',Contador_Ronda=>"1001",Sr=>ar_p9,Sc=>ac_p9);
A11:Permutacion port map(R=>ar_p9,C=>ac_p9,Ronda_A_B=>'0',Contador_Ronda=>"1010",Sr=>ar_p10,Sc=>ac_p10);
A12:Permutacion port map(R=>ar_p10,C=>ac_p10,Ronda_A_B=>'0',Contador_Ronda=>"1011",Sr=>ar_p11,Sc=>ac_p11);

B1: Permutacion port map(R=>R,C=>C,Ronda_A_B=>'1',Contador_Ronda=>"0000",Sr=>br_p0,Sc=>bc_p0);
B2: Permutacion port map(R=>br_p0,C=>bc_p0,Ronda_A_B=>'1',Contador_Ronda=>"0001",Sr=>br_p1,Sc=>bc_p1);
B3: Permutacion port map(R=>br_p1,C=>bc_p1,Ronda_A_B=>'1',Contador_Ronda=>"0010",Sr=>br_p2,Sc=>bc_p2);
B4: Permutacion port map(R=>br_p2,C=>bc_p2,Ronda_A_B=>'1',Contador_Ronda=>"0011",Sr=>br_p3,Sc=>bc_p3);
B5: Permutacion port map(R=>br_p3,C=>bc_p3,Ronda_A_B=>'1',Contador_Ronda=>"0100",Sr=>br_p4,Sc=>bc_p4);
B6: Permutacion port map(R=>br_p4,C=>bc_p4,Ronda_A_B=>'1',Contador_Ronda=>"0101",Sr=>br_p5,Sc=>bc_p5);
with Ronda select S<=
                      ar_p11&ac_p11 when '0',
                      br_p5&bc_p5 when others;
end Behavioral;