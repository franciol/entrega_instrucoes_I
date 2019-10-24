library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

-- EXTEND SIGNAL
entity CONTADOR is
    generic
    (
        larguraDadoEntrada : natural  :=    8;
        larguraDadoSaida   : natural  :=    8
    );
    port
    (
        -- Input ports
        ENTRADA_A : in std_logic_vector(larguraDadoEntrada-1 downto 0);
        ENTRADA_B : in std_logic_vector(larguraDadoEntrada-1 downto 0);
        -- Output ports
        SAIDA: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
end entity;

architecture NOTSIQUEIRA of CONTADOR is
begin
    SAIDA <= std_logic_vector(unsigned(ENTRADA_A) + unsigned(ENTRADA_B));
end architecture;