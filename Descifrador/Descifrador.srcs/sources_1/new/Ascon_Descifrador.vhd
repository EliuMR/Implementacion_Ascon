library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--k=128
--a=12
--b=6
--r=64 Datablock, textoplano y datos asociados
--Sr=64 bits
--Sc=256

entity Ascon_Descifrador is
  Port (llave: in std_logic_vector(127 downto 0);
        Nonce: in std_logic_vector(127 downto 0);
        datos_Asociados: in std_logic_vector(127 downto 0);
        texto_cifrado: in std_logic_vector(127 downto 0);
        reset,clock : in std_logic;
        Tag: in std_logic_vector(127 downto 0);
        texto_Descifrado: out std_logic_vector(127 downto 0));
--        tag: out std_logic_vector(127 downto 0));
end Ascon_Descifrador;

architecture Behavioral of Ascon_Descifrador is
component Bloque_Permutacion_Rondas is
  Port (R:in std_logic_vector(63 downto 0);
        C:in std_logic_vector(255 downto 0);
        Ronda:in std_logic;
        S:out std_logic_vector(319 downto 0));
end component;

component Maquina_Estados is
    Port ( reset,clock : in std_logic;
           c0: in std_logic_vector(255 downto 0);
           c1: in std_logic_vector(255 downto 0);
           c2: in std_logic_vector(255 downto 0);
           c3: in std_logic_vector(255 downto 0);
           c4: in std_logic_vector(255 downto 0);
           c5: in std_logic_vector(255 downto 0);
           
           r0: std_logic_vector(63 downto 0);
           r1: std_logic_vector(63 downto 0);
           r2: std_logic_vector(63 downto 0);
           r3: std_logic_vector(63 downto 0);
           r4: std_logic_vector(63 downto 0);
           r5: std_logic_vector(63 downto 0);
           
           ronda:out std_logic;
           R:out std_logic_vector(63 downto 0);
           C:out std_logic_vector(255 downto 0);
           contador:out std_logic_vector(2 downto 0));          
end component;
signal Estado_inicial: std_logic_vector(319 downto 0);
alias sr_inicial: std_logic_vector(63 downto 0) is Estado_Inicial(319 downto 256);
alias sc_inicial: std_logic_vector(255 downto 0) is Estado_Inicial(255 downto 0);

signal Estado: std_logic_vector(319 downto 0);
alias r: std_logic_vector(63 downto 0) is Estado(319 downto 256);
alias c: std_logic_vector(255 downto 0) is Estado(255 downto 0);

alias datos_Asociados0: std_logic_vector(63 downto 0) is datos_Asociados(127 downto 64);
alias datos_Asociados1: std_logic_vector(63 downto 0) is datos_Asociados(63 downto 0);

alias Texto0_cifrado: std_logic_vector(63 downto 0) is texto_cifrado(127 downto 64);
alias Texto1_cifrado: std_logic_vector(63 downto 0) is texto_cifrado(63 downto 0);

signal sc0: std_logic_vector(255 downto 0);
signal sc1: std_logic_vector(255 downto 0);
signal sc2: std_logic_vector(255 downto 0);
signal sc3: std_logic_vector(255 downto 0);
signal sc4: std_logic_vector(255 downto 0);
signal sc5: std_logic_vector(255 downto 0);

signal sr0: std_logic_vector(63 downto 0);
signal sr1: std_logic_vector(63 downto 0);
signal sr2: std_logic_vector(63 downto 0);
signal sr3: std_logic_vector(63 downto 0);
signal sr4: std_logic_vector(63 downto 0);
signal sr5: std_logic_vector(63 downto 0);

signal R_entrada: std_logic_vector(63 downto 0);
signal C_entrada: std_logic_vector(255 downto 0);
signal RondaAB: std_logic;

signal estado_contador: std_logic_vector(2 downto 0);
signal Texto0_descifrado:  std_logic_vector(63 downto 0);
signal Texto1_descifrado:  std_logic_vector(63 downto 0);
signal TextoDescifrado: std_logic_vector(127 downto 0);

signal tag_C: std_logic_vector(127 downto 0);
begin
Estado_inicial<="1000000001000000000011000000011000000000000000000000000000000000"&llave&Nonce;
--C's
sc0<=sc_inicial;
sc1<=c xor "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"&llave;
sc2<=c;
sc3<=c xor "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
sc4<=c;
sc5<=c xor llave&"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
--R's
sr0<=sr_inicial;
sr1<=r xor datos_Asociados0;
sr2<=r xor datos_Asociados1;
sr3<=Texto0_cifrado;
sr4<=Texto1_cifrado;
sr5<=r;
--tag
tag_C<=llave xor c(127 downto 0);
Estado_Acual: Maquina_Estados port map (reset=>reset,clock=>clock,c0=>sc0,c1=>sc1,c2=>sc2,c3=>sc3,c4=>sc4,c5=>sc5,r0=>sr0,r1=>sr1,r2=>sr2,r3=>sr3,r4=>sr4,r5=>sr5,ronda=>RondaAB,R=>R_entrada,C=>C_entrada,contador=>estado_contador);
Permutacion: Bloque_Permutacion_Rondas port map (R=>R_entrada,C=>C_entrada,Ronda=>RondaAB,S=>Estado);
process (estado_contador) begin        
         if estado_contador="011" then 
            Texto0_descifrado<=r xor Texto0_cifrado;
         elsif estado_contador="100" then 
            Texto1_descifrado<=r xor Texto1_cifrado;
         elsif estado_contador="101" then 
            if tag_C=Tag then
                TextoDescifrado<=Texto0_descifrado&Texto1_descifrado;      
            end if;
         end if;
                      
end process;
Texto_descifrado<=TextoDescifrado;
end Behavioral;
