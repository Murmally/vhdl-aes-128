library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES_Round is
port (
    DATA_IN : in std_logic_vector(127 downto 0);
    DATA_OUT : out std_logic_vector(127 downto 0);
    KEY_IN : in std_logic_vector(127 downto 0);
    KEY_OUT : inout std_logic_vector(127 downto 0);
    last_mux_sel : in std_logic;
    RCon : in std_logic_vector(7 downto 0));
end AES_Round;

architecture Behavioral of AES_Round is
  component KeyGenerator is
    port(
      INPUT : in  std_logic_vector (127 downto 0);
      rcon  :  in  std_logic_vector (7 downto 0);
      OUTPUT  :  out  std_logic_vector (127 downto 0));
  end component KeyGenerator;
  
  component Encryption_Round
  port(
      INPUT : in  std_logic_vector(127 downto 0);
      ROUND_KEY	: in  std_logic_vector(127 downto 0);
      last_mux_sel : in  std_logic;
      OUTPUT : out std_logic_vector(127 downto 0));
  end component Encryption_Round;
begin
  Key_Generator_map: KeyGenerator port map (
    INPUT => KEY_IN,
    rcon => RCon,
    OUTPUT => KEY_OUT);
    
  Encryption_Round_map: Encryption_Round port map (
    INPUT => DATA_IN,
    ROUND_KEY => KEY_OUT,
    last_mux_sel => last_mux_sel,
    OUTPUT => DATA_OUT);
    
end Behavioral;
