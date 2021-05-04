----------------------------------------------------------------------------------
-- Module Name: Encryption_round - Encryption_round_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Single iteration of encryption procedure.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Encryption_round is
port (
    INPUT        : in  std_logic_vector(127 downto 0);  -- input block
    ROUND_KEY    : in  std_logic_vector(127 downto 0);  -- appropriate key
    IS_LAST_ROUND : in  std_logic;                      -- whether round is the last one
    OUTPUT       : out std_logic_vector(127 downto 0)); -- output block
end Encryption_round;

architecture Encryption_round_architecture of Encryption_round is
    component SBox
    port (
        INPUT  : in  std_logic_vector(7 downto 0);
        OUTPUT : out std_logic_vector(7 downto 0));
    end component;
    
    component Shift_rows 
    port(
        INPUT  : in  std_logic_vector(127 downto 0);
        OUTPUT : out std_logic_vector(127 downto 0));
    end component;
    
    component Mix_columns
    port(
        INPUT  : in  std_logic_vector(127 downto 0);
        OUTPUT : out std_logic_vector(127 downto 0));
    end component;
    
    signal after_shift_rows : std_logic_vector(127 downto 0);
    signal after_byte_substitution : std_logic_vector(127 downto 0);
    signal after_mix_columns : std_logic_vector(127 downto 0);
    signal temp : std_logic_vector(127 downto 0);
begin
    -- generate Rijndael SBoxes for each byte
    generate_sboxes : for i in 15 downto 0 generate
        sbox_map : SBox
        port map(
            INPUT => INPUT(8*i+7 downto 8*i),
            OUTPUT => after_byte_substitution(8*i+7 downto 8*i));
    end generate generate_sboxes;
    
    -- perform shift row step
    shift_rows_map: Shift_rows port map(INPUT => after_byte_substitution, OUTPUT => after_shift_rows);
    
    -- perform mix columns step
    mixcolumn_map: Mix_columns port map(INPUT => after_shift_rows, OUTPUT => after_mix_columns);
    
    -- in case IS_LAST_ROUND is 1, it's the last round and the mix columns step is skipped
    temp <= after_mix_columns when IS_LAST_ROUND = '0' else after_shift_rows;
    
    -- final output assignment
    OUTPUT <= temp xor ROUND_KEY;
end Encryption_round_architecture;
