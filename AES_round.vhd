-------------------------------------------------------------------------------------------
-- Module Name: AES_round - Behavioral
-- Project Name: AES - Advanced Encryption Standard 
-- Description: Round consisting of generating appropriate key and using it for encryption.
-------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES_round is
port (
    DATA_IN : in std_logic_vector(127 downto 0);       -- input data block
    DATA_OUT : out std_logic_vector(127 downto 0);     -- output data block
    KEY_IN : in std_logic_vector(127 downto 0);        -- input key
    KEY_OUT : inout std_logic_vector(127 downto 0);    -- newly generated key
    IS_LAST_ROUND : in std_logic;                      -- whether round is the last one
    ROUND_CONSTANT : in std_logic_vector(7 downto 0)); -- round constant for this round
end AES_round;

architecture AES_round_architecture of AES_round is
  component Key_generator is
    port(
      INPUT : in  std_logic_vector (127 downto 0);
      ROUND_CONSTANT  :  in  std_logic_vector (7 downto 0);
      OUTPUT  :  out  std_logic_vector (127 downto 0));
  end component Key_generator;
  
  component Encryption_round
  port(
      INPUT : in  std_logic_vector(127 downto 0);
      ROUND_KEY	: in  std_logic_vector(127 downto 0);
      IS_LAST_ROUND : in  std_logic;
      OUTPUT : out std_logic_vector(127 downto 0));
  end component Encryption_round;
begin
  -- generate appropriate key for this round
  Key_Generator_map: Key_generator port map (
    INPUT => KEY_IN,
    ROUND_CONSTANT => ROUND_CONSTANT,
    OUTPUT => KEY_OUT);
  
  -- the round of encryption itself
  Encryption_Round_map: Encryption_round port map (
    INPUT => DATA_IN,
    ROUND_KEY => KEY_OUT,
    IS_LAST_ROUND => IS_LAST_ROUND,
    OUTPUT => DATA_OUT);
end AES_round_architecture;
