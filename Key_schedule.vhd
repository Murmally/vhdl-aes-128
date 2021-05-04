----------------------------------------------------------------------------------
-- Module Name: Key_schedule - Key_schedule_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Component that generates 10 subkeys out of 128 bit key.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Key_schedule is
port (
    INPUT : in std_logic_vector(127 downto 0);  -- input key
    KEY1, KEY2, KEY3, KEY4, KEY5, KEY6, KEY7, KEY8, KEY9, KEY10 : out std_logic_vector(127 downto 0));  -- output subkeys
end Key_schedule;

architecture Key_schedule_architecture of Key_schedule is
    component Key_generator is
    port (
        INPUT          : in std_logic_vector(127 downto 0);
        ROUND_CONSTANT : in std_logic_vector(7 downto 0);
        OUTPUT         : out std_logic_vector(127 downto 0));
    end component;
    
    -- round constants, as specified by NIST
    type Round_Constant_Array is array (0 to 9) of std_logic_vector(7 downto 0);
    signal Round_Constants : Round_Constant_Array := (X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1B", X"36");
    
    -- subkeys
    signal k1, k2, k3, k4, k5, k6, k7, k8, k9, k10 : std_logic_vector(127 downto 0);
begin
    -- key expansion rounds
    round_1 : Key_generator port map (INPUT, Round_Constants(0), k1);
    round_2 : Key_generator port map (k1, Round_Constants(1), k2);
    round_3 : Key_generator port map (k2, Round_Constants(2), k3);
    round_4 : Key_generator port map (k3, Round_Constants(3), k4);
    round_5 : Key_generator port map (k4, Round_Constants(4), k5);
    round_6 : Key_generator port map (k5, Round_Constants(5), k6);
    round_7 : Key_generator port map (k6, Round_Constants(6), k7);
    round_8 : Key_generator port map (k7, Round_Constants(7), k8);
    round_9 : Key_generator port map (k8, Round_Constants(8), k9);
    round_10 : Key_generator  port map (k9, Round_Constants(9), k10);
    
    -- assignment of subkeys to output signals
    KEY1 <= k1;
    KEY2 <= k2;
    KEY3 <= k3;
    KEY4 <= k4;
    KEY5 <= k5;
    KEY6 <= k6;
    KEY7 <= k7;
    KEY8 <= k8;
    KEY9 <= k9;
    KEY10 <= k10;
end Key_schedule_architecture;
