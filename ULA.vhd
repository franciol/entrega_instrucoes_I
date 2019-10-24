LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ULA IS
    GENERIC (
        larguraDados : NATURAL := 2
    );
    PORT (
        ENTRADA_A : IN std_logic_vector(larguraDados - 1 DOWNTO 0);
        ENTRADA_B : IN std_logic_vector(larguraDados - 1 DOWNTO 0);
        SAIDA : OUT std_logic_vector(larguraDados - 1 DOWNTO 0);
        INSTRUCAO : IN std_logic_vector(5 DOWNTO 0);
        CLK : IN std_logic
    );
END ENTITY;

ARCHITECTURE ulala OF ULA IS
BEGIN
    PROCESS (CLK)
    BEGIN
        IF (rising_edge(CLK)) THEN
            -- SOMA
            IF (INSTRUCAO = "00") THEN
                SAIDA <= std_logic_vector(unsigned(ENTRADA_A) + unsigned(ENTRADA_B));

            --SUBTRAI
            ELSIF (INSTRUCAO = "01") THEN
                SAIDA <= std_logic_vector(signed(ENTRADA_B) - signed(ENTRADA_A));

            -- PASSA A
            ELSIF (INSTRUCAO = "10") THEN
                SAIDA <= ENTRADA_A;

            -- PASSA B
            ELSE
                SAIDA <= ENTRADA_B;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;