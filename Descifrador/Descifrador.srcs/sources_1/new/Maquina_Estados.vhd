library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Maquina_Estados is
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
end Maquina_Estados;

architecture Behavioral of Maquina_Estados is
    type state is (cero,uno,dos,tres,cuatro,cinco);
    signal pr_state, nx_state: state;
begin
    process (reset,clock)
    begin
        if (reset='1') then 
            pr_state<=cero;
        elsif (clock'event and clock='1') then
            pr_state<=nx_state;
        end if;
    end process;
    
    anterior:
    process(pr_state)
    begin
        case pr_state is
            when cero =>
                R<=r0;
                C<=c0;
                Ronda<='0';
                nx_state<=uno;
                contador<="000";
            when uno =>
                R<=r1;
                C<=c1;
                nx_state<=dos;
                Ronda<='1';
                contador<="001";
            when dos =>
                R<=r2;
                C<=c2;
                nx_state<=tres;
                Ronda<='1';
                contador<="010";
            when tres =>
                R<=r3;
                C<=c3;
                nx_state<=cuatro;
                Ronda<='1';
                contador<="011";
            when cuatro =>
                R<=r4;
                C<=c4;
                nx_state<=cinco;
                Ronda<='1';
                contador<="100";
            when cinco =>
                R<=r5;
                C<=c5;
                nx_state<=cero;
                Ronda<='0';
                contador<="101";
        end case;
    end process anterior;
end Behavioral;
