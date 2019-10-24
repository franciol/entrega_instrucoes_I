LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY muxGenerico IS
    GENERIC (
        -- Total de bits das entradas e saidas
        larguraDados : NATURAL := 8

    );
    PORT (
        entradaA_MUX : IN std_logic_vector(larguraDados - 1 DOWNTO 0);
        entradaB_MUX : IN std_logic_vector(larguraDados - 1 DOWNTO 0);
        seletor_MUX : IN std_logic;

        saida_MUX : OUT std_logic_vector(larguraDados - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE comportamento OF muxGenerico IS
BEGIN
    saida_MUX <= -- SAIDA DA MUX
    entradaA_MUX when (seletor_MUX = '0') else
    entradaB_MUX;
END ARCHITECTURE;

