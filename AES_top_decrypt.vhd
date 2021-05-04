----------------------------------------------------------------------------------
-- Module Name: AES_top_decrypt - AES_top_decrypt_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Top level component of AES decryption.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_decryption is
port (
--    CLK_in   : std_logic;
--    RESET_in : std_logic;
    INPUT    : in std_logic_vector(127 downto 0);   -- input ciphertext
    KEY      : in std_logic_vector(127 downto 0);   -- input key
    OUTPUT   : out std_logic_vector(127 downto 0)); -- output plaintext
    -- X1, X2, X3, X4, X5, X6, X7, X8, X9, X10 : out std_logic_vector(127 downto 0)); 
end TOP_decryption;

architecture TOP_decryption_architecture of TOP_decryption is
    component Reg is
    port (
        CLK : std_logic;
        RESET : std_logic;
        INPUT : in std_logic_vector(127 downto 0);
        OUTPUT : out std_logic_vector(127 downto 0));
    end component;
    
    component Key_schedule is
    port (
        INPUT : in std_logic_vector(127 downto 0);
        KEY1, KEY2, KEY3, KEY4, KEY5, KEY6, KEY7, KEY8, KEY9, KEY10 : out std_logic_vector(127 downto 0));
    end component;
    
    component Decryption_round
    port(
        INPUT         : in  std_logic_vector(127 downto 0);
        ROUND_KEY	  : in  std_logic_vector(127 downto 0);
        IS_LAST_ROUND : in  std_logic;
        OUTPUT        : out std_logic_vector(127 downto 0));
    end component;
    
    -- round results
    signal r1_in, r2_in, r3_in, r4_in, r5_in, r6_in, r7_in, r8_in, r9_in  : std_logic_vector(127 downto 0);
    signal r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out  : std_logic_vector(127 downto 0);
    signal r1, r2, r3, r4, r5, r6, r7, r8, r9  : std_logic_vector(127 downto 0);
    
    -- subkeys
    signal input_key, k1, k2, k3, k4, k5, k6 ,k7, k8, k9, k10 : std_logic_vector(127 downto 0);
    
    -- round 1 input
    signal Round_1_IN : std_logic_vector(127 downto 0);
begin
    -- input key to 1st round of decryption is the last subkey, therefore we need to generate all keys beforehand
    Key_schedule_map : Key_schedule port map (KEY, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10);
--    X1 <= k1;
--    X2 <= k2;
--    X3 <= k3;
--    X4 <= k4;
--    X5 <= k5;
--    X6 <= k6;
--    X7 <= k7;
--    X8 <= k8;
--    X9 <= k9;
--    X10 <= k10;
    
    Round_1_IN <= INPUT xor k10;
    round_1 : Decryption_round port map (Round_1_IN, k9, '0', r1);
    round_2 : Decryption_round port map (r1, k8, '0', r2);
    round_3 : Decryption_round port map (r2, k7, '0', r3);
    round_4 : Decryption_round port map (r3, k6, '0', r4);
    round_5 : Decryption_round port map (r4, k5, '0', r5);
    round_6 : Decryption_round port map (r5, k4, '0', r6);
    round_7 : Decryption_round port map (r6, k3, '0', r7);
    round_8 : Decryption_round port map (r7, k2, '0', r8);
    round_9 : Decryption_round port map (r8, k1, '0', r9);
    round_10 : Decryption_round port map (r9, KEY, '1', OUTPUT);
    
    -- decryption rounds themselves
--    Round_1_IN <= INPUT xor k10;
--    round_1 : Decryption_round port map (Round_1_IN, k9, '0', r1_in);
--    round_2 : Decryption_round port map (r1, k8, '0', r2_in);
--    round_3 : Decryption_round port map (r2, k7, '0', r3_in);
--    round_4 : Decryption_round port map (r3, k6, '0', r4_in);
--    round_5 : Decryption_round port map (r4, k5, '0', r5_in);
--    round_6 : Decryption_round port map (r5, k4, '0', r6_in);
--    round_7 : Decryption_round port map (r6, k3, '0', r7_in);
--    round_8 : Decryption_round port map (r7, k2, '0', r8_in);
--    round_9 : Decryption_round port map (r8, k1, '0', r9_in);
--    round_10 : Decryption_round port map (r9, KEY, '1', OUTPUT);
    
--    -- registers for round results
--    r1_reg : Reg port map (CLK_in, RESET_in, r1_in, r1_out);
--    r2_reg : Reg port map (CLK_in, RESET_in, r2_in, r2_out);
--    r3_reg : Reg port map (CLK_in, RESET_in, r3_in, r3_out);
--    r4_reg : Reg port map (CLK_in, RESET_in, r4_in, r4_out);
--    r5_reg : Reg port map (CLK_in, RESET_in, r5_in, r5_out);
--    r6_reg : Reg port map (CLK_in, RESET_in, r6_in, r6_out);
--    r7_reg : Reg port map (CLK_in, RESET_in, r7_in, r7_out);
--    r8_reg : Reg port map (CLK_in, RESET_in, r8_in, r8_out);
--    r9_reg : Reg port map (CLK_in, RESET_in, r9_in, r9_out);
    
--    main_assignment : process(CLK_in)
--    begin
--        input_key <= KEY;
--        r1 <= r1_out;
--        r2 <= r2_out;
--        r3 <= r3_out;
--        r4 <= r4_out;
--        r5 <= r5_out;
--        r6 <= r6_out;
--        r7 <= r7_out;
--        r8 <= r8_out;
--        r9 <= r9_out;
--    end process;
end TOP_decryption_architecture;
