LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TOPZERA IS
    GENERIC (
        larguraBarramentoImediato : NATURAL := 16;
        larguraBarramentoEnderecos : NATURAL := 32;
        larguraBarramentoDados : NATURAL := 5
    );
    PORT (
        CLK : IN STD_LOGIC
    );
END ENTITY;
-- LOVELY TOP LEVEL
ARCHITECTURE TOPPER OF TOPZERA IS
    SIGNAL SAIDA_PC, SAIDA_ADDER, SAIDA_ROM, SAIDA_BREG_A, SAIDA_BREG_B, SAIDA_ULALA, SAIDA_IMEDIATO : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SAIDA_UC_ULA : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL SAIDA_UC_PC, SAIDA_UC_BREG : STD_LOGIC;
BEGIN

    ULALA : ENTITY work.ULA
        GENERIC MAP(
            larguraDados => larguraBarramentoEnderecos
        )
        PORT MAP
        (
            ENTRADA_A => SAIDA_BREG_A,
            ENTRADA_B => SAIDA_BREG_B,
            SAIDA => SAIDA_ULALA,
            INSTRUCAO => SAIDA_UC_ULA,
            CLK => CLK
        );

    PC : ENTITY work.registradorGenerico
        GENERIC MAP(
            larguraDados => 32
        )
        PORT MAP(
            DIN => SAIDA_ADDER,
            DOUT => SAIDA_PC,
            ENABLE => '1',
            CLK => CLK,
            RST => '0'
        );

    ADDER : ENTITY work.CONTADOR
        GENERIC MAP(
            larguraDadoEntrada => 32,
            larguraDadoSaida => 32
        )
        PORT MAP(
            ENTRADA => SAIDA_PC,
            SAIDA => SAIDA_ADDER
        );

    ROMS : ENTITY work.ROM
        GENERIC MAP(
            dataWidth => 32,
            addrWidth => 32
        )
        PORT MAP(
            Dado => SAIDA_IMEDIATO,
            Endereco => SAIDA_PC
        );

    BANCOREG : ENTITY work.BancoReg
        GENERIC MAP(
            larguraDados =>32,
            larguraEndBancoRegs => 5
        )
        PORT MAP(
            clk => CLK,
            enderecoA => SAIDA_IMEDIATO(25 DOWNTO 21),
            enderecoB =>SAIDA_IMEDIATO(20 DOWNTO 16),
            enderecoC => SAIDA_IMEDIATO(15 DOWNTO 11),
            dadoEscritaC => SAIDA_ULALA,
            escreveC => SAIDA_UC_BREG,
            saidaA => SAIDA_BREG_A,
            saidaB => SAIDA_BREG_B
        );

    UC : ENTITY work.UCONTROLE
        GENERIC MAP(
            DATA_SIZE => 32
        )
        PORT MAP(
            DATA => SAIDA_IMEDIATO,
            SAIDA_PC => SAIDA_UC_PC,
            SAIDA_REG => SAIDA_UC_BREG,
            SAIDA_ULA =>  SAIDA_UC_ULA
        );
END ARCHITECTURE;