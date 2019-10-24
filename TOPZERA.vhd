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
    SIGNAL SAIDA_PC, SAIDA_ADDER, SAIDA_ADDER42, SAIDA_ROM, SAIDA_RAM, SAIDA_BREG_A, SAIDA_BREG_B, SAIDA_ULALA, SAIDA_IMEDIATO, SAIDA_ESTSIN, SAIDA_MUXULA, SAIDA_MUXLOAD, SAIDA_MUXBEQ : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SAIDA_MUXREG : STD_LOGIC_VECTOR(4 DOWNTO 0);
	 SIGNAL SAIDA_UC_ULA : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL SAIDA_UC_PC, SAIDA_UC_BREG, SAIDA_UC_MUXREG, SAIDA_UC_MUXULA, SAIDA_UC_MUXLOAD, SAIDA_UC_MUXBEQ : STD_LOGIC;
BEGIN

    ULALA : ENTITY work.ULA
        GENERIC MAP(
            larguraDados => larguraBarramentoEnderecos
        )
        PORT MAP
        (
            ENTRADA_A => SAIDA_BREG_A,
            ENTRADA_B => SAIDA_MUXULA,
            SAIDA => SAIDA_ULALA,
            INSTRUCAO => SAIDA_UC_ULA,
            CLK => CLK
        );

    PC : ENTITY work.registradorGenerico
        GENERIC MAP(
            larguraDados => 32
        )
        PORT MAP(
            DIN => SAIDA_MUXBEQ,
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
            ENTRADA_A => 4,
            ENTRADA_B => SAIDA_PC,
            SAIDA => SAIDA_ADDER
        );
		  
	 ADDER42 : ENTITY work.CONTADOR
        GENERIC MAP(
            larguraDadoEntrada => 32,
            larguraDadoSaida => 32
        )
        PORT MAP(
            ENTRADA_A => SAIDA_ADDER,
            ENTRADA_B => (SAIDA_ESTSIN << 2),
            SAIDA => SAIDA_ADDER42
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

    RAMS : ENTITY work.RAM
        GENERIC MAP(
            dataWidth => 32,
            addrWidth => 32
        )
        PORT MAP(
            addr => SAIDA_ULALA,
            we => xxxxxxxxxxxxx,
				clk => CLK,
            dado_in => SAIDA_BREG_B,
				dado_out => SAIDA_RAM
        );

    BANCOREG : ENTITY work.BancoReg
        GENERIC MAP(
            larguraDados =>32,
            larguraEndBancoRegs => 5
        )
        PORT MAP(
            clk => CLK,
            enderecoA => SAIDA_IMEDIATO(25 DOWNTO 21),
            enderecoB => SAIDA_IMEDIATO(20 DOWNTO 16),
            enderecoC => SAIDA_MUXREG,
            dadoEscritaC => SAIDA_MUXLOAD,
            escreveC => SAIDA_UC_BREG,
            saidaA => SAIDA_BREG_A,
            saidaB => SAIDA_BREG_B
        );

    ESTSIN : ENTITY work.ExtensorSinal
        GENERIC MAP(
            larguraDadoEntrada => 16,
				larguraDadoSaida => 32
        )
        PORT MAP(
            estendeSinal_IN => SAIDA_IMEDIATO(15 DOWNTO 0),
            estendeSinal_OUT => SAIDA_ESTSIN
        );

    MUXREG : ENTITY work.muxGenerico
        GENERIC MAP(
            larguraDados => 5
        )
        PORT MAP(
            entradaA_MUX => SAIDA_IMEDIATO(20 DOWNTO 16),
            entradaB_MUX => SAIDA_IMEDIATO(15 DOWNTO 11),
            seletor_MUX => SAIDA_UC_MUXREG,
            saida_MUX =>  SAIDA_MUXREG
        );
		  
    MUXULA : ENTITY work.muxGenerico
        GENERIC MAP(
            larguraDados => 32
        )
        PORT MAP(
            entradaA_MUX => SAIDA_BREG_B,
            entradaB_MUX => SAIDA_ESTSIN,
            seletor_MUX => SAIDA_UC_MUXULA,
            saida_MUX =>  SAIDA_MUXULA
        );

    MUXLOAD : ENTITY work.muxGenerico
        GENERIC MAP(
            larguraDados => 32
        )
        PORT MAP(
            entradaA_MUX => SAIDA_ULALA,
            entradaB_MUX => SAIDA_RAM,
            seletor_MUX => SAIDA_UC_MUXLOAD,
            saida_MUX =>  SAIDA_MUXLOAD
        );

    MUXBEQ : ENTITY work.muxGenerico
        GENERIC MAP(
            larguraDados => 32
        )
        PORT MAP(
            entradaA_MUX => SAIDA_ADDER,
            entradaB_MUX => SAIDA_ADDER42,
            seletor_MUX => SAIDA_UC_MUXBEQ and xxxxxxxxxx,
            saida_MUX =>  SAIDA_MUXBEQ
        );
		  
    UC : ENTITY work.UControle
        GENERIC MAP(
            DATA_SIZE => 32
        )
        PORT MAP(
            DATA => SAIDA_IMEDIATO,
            SAIDA_ULA => SAIDA_UC_ULA,
            SAIDA_PC => SAIDA_UC_PC,
            SAIDA_REG => SAIDA_UC_BREG,
				SAIDA_MUXREG => SAIDA_UC_MUXREG,
				SAIDA_MUXULA => SAIDA_UC_MUXULA,
				SAIDA_MUXLOAD => SAIDA_UC_MUXLOAD,
				SAIDA_MUXBEQ => SAIDA_UC_MUXBEQ
        );
END ARCHITECTURE;