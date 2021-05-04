library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity AES_top_decrypt_tb is
end;

architecture bench of AES_top_decrypt_tb is
  component TOP_decryption
  port (
      INPUT : in std_logic_vector(127 downto 0);
      KEY : in std_logic_vector(127 downto 0);
      OUTPUT : out std_logic_vector(127 downto 0));
  end component;

  signal INPUT: std_logic_vector(127 downto 0);
  signal KEY: std_logic_vector(127 downto 0);
  signal OUTPUT: std_logic_vector(127 downto 0);
begin
  uut: Top_decryption port map (INPUT, KEY, OUTPUT);

  stimulus: process
  begin
    KEY <= X"5468617473206D79204B756E67204675";
    INPUT <= X"29C3505F571420F6402299B31A02D73A";
    wait for 5ns;
    
    KEY <= X"000102030405060708090a0b0c0d0e0f";
    INPUT <= X"69c4e0d86a7b0430d8cdb78070b4c55a";
    wait;
  end process;
end;