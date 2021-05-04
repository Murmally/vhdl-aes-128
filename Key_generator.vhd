----------------------------------------------------------------------------------
-- Module Name: Key_generator - Key_generator_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Component that turns INPUT subkey into another iteration of subkey.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Key_generator is
port (
    INPUT  : in  std_logic_vector(127 downto 0);         -- input key
    ROUND_CONSTANT   : in  std_logic_vector(7 downto 0); -- round constant for given key schedule round
    OUTPUT : out  std_logic_vector(127 downto 0));       -- output key
end Key_generator;

architecture Key_generator_architecture of Key_generator is
    component Sbox is
    port (
        INPUT  : in std_logic_vector(7 downto 0);
        OUTPUT : out std_logic_vector(7 downto 0));
    end component;
    
    -- separate words into which the INPUT will be split
    signal word0, word1, word2, word3 : std_logic_vector(31 downto 0);
    signal new_word0, new_word1, new_word2, new_word3: std_logic_vector(31 downto 0);
    signal last_word, sub_word_after_xor :std_logic_vector(31 downto 0);
    signal substituted_word, shifted_word : std_logic_vector(31 downto 0);
begin
    -- split input into words
    word0 <= INPUT(127 downto 96);
    word1 <= INPUT(95 downto 64);
    word2 <= INPUT(63 downto 32);
    word3 <= INPUT(31 downto 0);
    
    -- take last word from input and shift it by 8 bits
    last_word <= INPUT(31 downto 0);
    shifted_word <= last_word(23 downto 0) & last_word(31 downto 24);

    -- substitute separate bytes in shifted word
    Sbox_1_map : Sbox port map(INPUT => shifted_word(7 downto 0), OUTPUT => substituted_word(7 downto 0));
    Sbox_2_map : Sbox port map(INPUT => shifted_word(15 downto 8), OUTPUT => substituted_word(15 downto 8));
    Sbox_3_map : Sbox port map(INPUT => shifted_word(23 downto 16), OUTPUT => substituted_word(23 downto 16));
    Sbox_4_map : Sbox port map(INPUT => shifted_word(31 downto 24), OUTPUT => substituted_word(31 downto 24));

    -- XOR the upper byte of substituted word with round constant
    sub_word_after_xor <= (substituted_word(31 downto 24) xor ROUND_CONSTANT) & substituted_word(23 downto 0);

    -- perform XOR over words in sequence
    new_word0 <= sub_word_after_xor xor word0;
    new_word1 <= new_word0 xor word1;
    new_word2 <= new_word1 xor word2;
    new_word3 <= new_word2 xor word3; 
    
    -- concatenate the new words and assign to OUTPUT
    OUTPUT <= new_word0 & new_word1 & new_word2 & new_word3;
end Key_generator_architecture;
