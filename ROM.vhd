LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Projeito feito por    Francisco Aveiro
--                       Giulia Passarelli
--                       Alexandre Edington
ENTITY ROM IS
    GENERIC (
        dataWidth : NATURAL := 32;
        addrWidth : NATURAL := 32
    );
    PORT (
        Endereco : IN std_logic_vector (addrWidth - 1 DOWNTO 0);
        Dado : OUT std_logic_vector (dataWidth - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE takitaki OF ROM IS

    TYPE blocoMemoria IS ARRAY(0 TO 2 ** 20 - 1) OF std_logic_vector(dataWidth - 1 DOWNTO 0);

    FUNCTION initMemory
        RETURN blocoMemoria IS VARIABLE tmp : blocoMemoria := (OTHERS => (OTHERS => '0'));
    BEGIN
        -- Inicializa os endereços e escreve ASSEMBLY!!!! :
		  
        tmp(1) := x"00000000";
        
		      

        RETURN tmp;
    END initMemory;

    SIGNAL memROM : blocoMemoria := initMemory;

BEGIN
    Dado <= memROM (to_integer(unsigned(Endereco)));
END ARCHITECTURE;