library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity rom is
    -- Declaracao de constates
    generic (
        addressSize : natural := 8;
        wordSize    : natural := 8;
        mifFileName : string := "rom.dat"
    );
    -- Declaracao de entradas e saidas
    port (
        addr   : in bit_vector (addressSize - 1 downto 0);
        data   : out bit_vector (wordSize - 1 downto 0)
    );
end rom;

architecture logic of rom is
    -- Area declarativa
    type mem_tipo is array (0 to integer'(2)**addressSize - 1) of bit_vector (wordSize - 1 downto 0);
    
    -- Funcao para inicializacao da mem, com variaveis para a sua iteracao
    impure function inicia_mem (mif_File_Name : in string) return mem_tipo is
        FILE f : TEXT open read_mode is mifFileName; -- Instacia de arquivo
        variable l : LINE; -- Variavel auxiliar para a iteracao
        variable i : integer := 0; -- Variaveis para iteracao de laco
        variable wi : bit_vector(wordSize - 1 downto 0); -- Palavra para iteracao
        variable mem : mem_tipo; -- Memoria de iteracao

    begin

        for i in mem_tipo'range loop
            readline (f,l);
            read (L, wi);
            mem (i)  := wi;
        end loop;
        return mem;                    
        
    end;

    constant mem : mem_tipo := inicia_mem (mifFileName);
        
    begin
        data <= mem(to_integer(unsigned(addr)));

end logic;
