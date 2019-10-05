library ieee;

use ieee.numeric_bit.all;

entity reg is
generic (wordSize: natural :=4);
port (
    clock: in bit; -- Entrada de Clock
    reset: in bit; -- Clear assincrono
    load:  in bit; -- Enable da escrita
    d:     in bit_vector (wordSize -1 downto 0); -- Entrada
    q:     out bit_vector (wordSize -1 downto 0) -- Saida
);
end reg;

architecture logic of reg is

begin

    process (clock)
    
    begin

        if (clock'EVENT and clock = '1') then
            if (load ='1') then
                q <= d;
            end if;
        end if;

        if (reset = '1') then
            q <= (others => '0');
        end if;

    end process;
end logic;


                