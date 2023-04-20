library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Permutacion is
  Port (R:in std_logic_vector(63 downto 0);
        C:in std_logic_vector(255 downto 0);
        Ronda_A_B: in std_logic;
        Contador_Ronda: in std_logic_vector(3 downto 0);
        Sr:out std_logic_vector(63 downto 0);
        Sc:out std_logic_vector(255 downto 0));
end Permutacion;

architecture Behavioral of Permutacion is
signal S_inicial: std_logic_vector(319 downto 0);
signal S_Adicion_constante: std_logic_vector(319 downto 0);
signal S_Substitucion: std_logic_vector(319 downto 0);
signal S_Difusion_Lineal: std_logic_vector(319 downto 0);

component Adicion_Constante is
  Port (Estado: in std_logic_vector(319 downto 0);
        Ronda: in std_logic;
        Contador: in std_logic_vector(3 downto 0);
        EstadoSuma: out std_logic_vector(319 downto 0));
end component;

component Difusion_Lineal is
  Port (Estado: in std_logic_vector(319 downto 0);
        EstadoDifusion: out std_logic_vector(319 downto 0));
end component;

component Substitucion is
  Port (Estado: in std_logic_vector(319 downto 0);
        EstadoSubstitucion: out std_logic_vector(319 downto 0));
end component;
begin
S_inicial<=R&C;
--Constante
Pc: Adicion_Constante port map(
Estado=>S_inicial,Ronda=>Ronda_A_B,
Contador=>Contador_Ronda,EstadoSuma=>S_Adicion_Constante);
--Substitucion
Ps: Substitucion port map (Estado=>S_Adicion_Constante,
EstadoSubstitucion=>S_Substitucion);
--Difusion Lineal
Pl: Difusion_Lineal port map (Estado=>S_Substitucion,
EstadoDifusion=>S_Difusion_Lineal);

Sr<=S_Difusion_Lineal(63 downto 0);
Sc<=S_Difusion_Lineal(255 downto 0);
end Behavioral;