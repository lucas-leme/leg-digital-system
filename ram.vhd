library ieee;

use ieee.numeric_bit.all;

entity ram is
    -- Declaracao de constates
    generic (
        addressSize : natural := 8;
        wordSize   : natural := 8
    );
    -- Declaracao de entradas e saidas
    port (
        ck, wr : in bit;
        addr   : in bit_vector (addressSize - 1 downto 0);
        data_i : in bit_vector (wordSize - 1 downto 0);
        data_o : out bit_vector (wordSize - 1 downto 0)
    );
end ram;

architecture logic of ram is
    -- Area declarativa
    type mem_tipo is array (0 to integer'(2)**addressSize - 1) of bit_vector (wordSize - 1 downto 0);
    signal mem : mem_tipo;

begin
        
    process(ck)
    begin
        -- Clock em borda de subida
        if (ck'EVENT AND ck = '1') then
            
            -- Enable de escrita = '1'
            if (wr = '1') then 
                mem(to_integer(unsigned(addr))) <= data_i;
            end if;

        end if;
    end process;

    -- Saida assincrona
    data_o <= mem (to_integer(unsigned(addr)));

end logic;
