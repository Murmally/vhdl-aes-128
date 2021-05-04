----------------------------------------------------------------------------------
-- Module Name: Decryption_round - Decryption_round_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description:  Component representing iteration of decryption.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decryption_round is
port(
    INPUT        :	in  std_logic_vector(127 downto 0);  -- input block
    ROUND_KEY	 :	in  std_logic_vector(127 downto 0);  -- input round subkey
    IS_LAST_ROUND :	in  std_logic;                       -- determines whether round is last
    OUTPUT       :	out std_logic_vector(127 downto 0)); -- output block
end Decryption_round;

architecture Decryption_round_architecture of Decryption_round is
    component SBox_inv
    port(
        INPUT    :	in  std_logic_vector(7 downto 0);
        OUTPUT   :	out std_logic_vector(7 downto 0));
    end component;
    
    component Shift_rows_inv 
    port(
        INPUT     :   in  std_logic_vector(127 downto 0);
        OUTPUT    :   out std_logic_vector(127 downto 0));
    end component;
    
    component Mix_columns_inv
    port(
        INPUT  :   in  std_logic_vector(127 downto 0);
        OUTPUT :   out std_logic_vector(127 downto 0));
    end component;
    
    signal after_shift_rows : std_logic_vector(127 downto 0);
    signal after_byte_substitution : std_logic_vector(127 downto 0);
    signal after_mix_columns : std_logic_vector(127 downto 0);
    signal temp : std_logic_vector(127 downto 0);
begin
    -- first is the step of shifting rows
    shift_rows_map : Shift_rows_inv port map(INPUT => INPUT, OUTPUT => after_shift_rows);
    
    -- generate SBoxes for each byte of shifted block
    generate_sboxes : for i in 15 downto 0 generate
        sbox_map : SBox_inv
        port map (
            INPUT => after_shift_rows(8*i + 7 downto 8*i),
            OUTPUT => after_byte_substitution(8*i + 7 downto 8*i));
    end generate generate_sboxes;
    
    -- add round key
    temp <= after_byte_substitution xor ROUND_KEY;
    
    -- perform the step of mixing columns
    mix_columns_map: Mix_columns_inv port map (INPUT => temp, OUTPUT => after_mix_columns);
    
    -- in case IS_LAST_ROUND is 1, it's the last round and the mix columns step is skipped
    OUTPUT <= after_mix_columns when IS_LAST_ROUND = '0' else temp;
end Decryption_round_architecture;
