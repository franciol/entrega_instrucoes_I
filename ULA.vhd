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
            -- ADD
            IF (INSTRUCAO = x"20") THEN
                SAIDA <= std_logic_vector(signed(ENTRADA_A) + signed(ENTRADA_B));

                --ADD unsigned
            ELSIF (INSTRUCAO = x"21") THEN
                SAIDA <= std_logic_vector(unsigned(ENTRADA_B) - unsigned(ENTRADA_A));

                -- AND
            ELSIF (INSTRUCAO = x"24") THEN
                SAIDA <= ENTRADA_A AND ENTRADA_B;

                -- NOR
            ELSIF (INSTRUCAO = x"27") THEN
                SAIDA <= ENTRADA_A NOR ENTRADA_B;

                -- OR
            ELSIF (INSTRUCAO = x"25") THEN
                SAIDA <= ENTRADA_A OR ENTRADA_B;

            ELSE
                SAIDA <= ENTRADA_B;
                
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;