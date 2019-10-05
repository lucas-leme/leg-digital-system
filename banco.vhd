library ieee;

use ieee.numeric_bit.all;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity regfile is
    generic (
        regn: natural := 32;
        wordSize: natural := 64
    );
    port (
        clock: in bit;
        reset: in bit;
        regWrite: in bit; -- Enable de escrita geral
        rr1, rr2, wr: in bit_vector (natural(ceil(log2(real(regn)))) -1 downto 0); -- Enable de escrita individual
        d: in bit_vector (wordSize -1 downto 0); -- Entrada
        q1, q2: out bit_vector (wordSize -1 downto 0) -- Saidas
    );
end regfile;

architecture logic of regfile is

    type reg_list is array (regn -1 downto 0) of bit_vector (wordSize-1 downto 0);
    signal pre_q: reg_list; -- Armazenamento intermediario das palavras

begin

    process (clock, reset, regWrite)

    begin

        if (clock'EVENT and clock = '1') then

            if (regWrite = '1') then
                if (to_integer(unsigned(wr)) /= regn-1) then
                    pre_q(to_integer(unsigned(wr))) <= d; -- Atribuicao no registrador requerido
                end if;
            else
                pre_q(regn -1) <= (others => '0'); -- 0 no registrador XZR
            end if;
        elsif (reset = '1') then
            for i in regn -1 downto 0 loop
                pre_q(i) <= (others => '0'); -- Reset geral
            end loop;
        end if;

    end process;

    q1 <= pre_q(to_integer(unsigned(rr1))); -- Saida 1
    q2 <= pre_q(to_integer(unsigned(rr2))); -- Saida 2            

end logic;