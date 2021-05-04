----------------------------------------------------------------------------------
-- Module Name: Reg - Reg_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Simple register used for pipelining.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
port (
    CLK    : in std_logic;                         -- clock
    RESET  : in std_logic;                         -- reset signal
    INPUT  : in std_logic_vector(127 downto 0);    -- input value
    OUTPUT : out std_logic_vector(127 downto 0));  -- output value
end Reg;

architecture Reg_architecture of Reg is
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            OUTPUT <= (others => '0');
        elsif rising_edge(CLK) then
            OUTPUT <= INPUT;
        end if;
    end process;
end Reg_architecture;
