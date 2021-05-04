----------------------------------------------------------------------------------
-- Module Name: TOP - TOP_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Top module of AES implementation.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_encryption is
port (
    CLK_in : in std_logic;                           -- clock
    RESET_in : in std_logic;                         -- reset signal
    READ_MEM_EN : out std_logic;                     -- enable read from memory
    WRITE_MEM_EN : out std_logic;                    -- enable write to memory
    DATA_IN : in std_logic_vector(127 downto 0);     -- input data
    KEY : in std_logic_vector(127 downto 0);         -- input key
    DATA_OUT : out std_logic_vector(127 downto 0);   -- output data
    ADDR_READ : out std_logic_vector(31 downto 0);   -- read address
    ADDR_WRITE : out std_logic_vector(31 downto 0);  -- write address
    WRITE_READY : out std_logic_vector(15 downto 0); -- component is ready to write output to memory
    READ_READY : out std_logic_vector(15 downto 0)); -- component is ready to accept new block of data
end TOP_encryption;

architecture TOP_architecture of TOP_encryption is
    component Reg is
    port (
        CLK : std_logic;
        RESET : std_logic;
        INPUT : in std_logic_vector(127 downto 0);
        OUTPUT : out std_logic_vector(127 downto 0));
    end component;
   
    component AES_round is
    port (
        DATA_IN        : in std_logic_vector(127 downto 0);
        DATA_OUT       : out std_logic_vector(127 downto 0);
        KEY_IN         : in std_logic_vector(127 downto 0);
        KEY_OUT        : inout std_logic_vector(127 downto 0);
        IS_LAST_ROUND  : in std_logic;
        ROUND_CONSTANT : in std_logic_vector(7 downto 0));
    end component;
    
    -- array of round constants as specified by NIST
    type Round_Constant_Array is array (0 to 9) of std_logic_vector(7 downto 0);
    signal Round_Constants : Round_Constant_Array := (X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1B", X"36");
    
    -- address where the blcok memory starts
    signal Memory_IN_Address : std_logic_vector(31 downto 0) := X"40000000";
    signal Memory_OUT_Address : std_logic_vector(31 downto 0) := X"40000000";
    
    -- round results
    signal r1_in, r2_in, r3_in, r4_in, r5_in, r6_in, r7_in, r8_in, r9_in  : std_logic_vector(127 downto 0);
    signal r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out  : std_logic_vector(127 downto 0);
    signal r1, r2, r3, r4, r5, r6, r7, r8, r9  : std_logic_vector(127 downto 0);
    
    -- subkeys
    signal k1_in, k2_in, k3_in, k4_in, k5_in, k6_in, k7_in, k8_in, k9_in, k10_in : std_logic_vector(127 downto 0);
    signal k1_out, k2_out, k3_out, k4_out, k5_out, k6_out, k7_out, k8_out, k9_out, k10_out : std_logic_vector(127 downto 0);
    signal k1, k2, k3, k4, k5, k6, k7, k8, k9, k10 : std_logic_vector(127 downto 0);
    
    -- input for the first round
    signal Round_1_IN : std_logic_vector(127 downto 0);
begin
    -- add key before first iteration
    Round_1_IN <= KEY xor DATA_IN;
    
    -- encryption rounds
    round_1: AES_round port map (Round_1_IN, r1_in, KEY, k1_in, '0', Round_Constants(0)); 
    round_2: AES_round port map (r1, r2_in, k1, k2_in, '0', Round_Constants(1));
    round_3: AES_round port map (r2, r3_in, k2, k3_in, '0', Round_Constants(2));
    round_4: AES_round port map (r3, r4_in, k3, k4_in, '0', Round_Constants(3));
    round_5: AES_round port map (r4, r5_in, k4, k5_in, '0', Round_Constants(4));
    round_6: AES_round port map (r5, r6_in, k5, k6_in, '0', Round_Constants(5));
    round_7: AES_round port map (r6, r7_in, k6, k7_in, '0', Round_Constants(6));
    round_8: AES_round port map (r7, r8_in, k7, k8_in, '0', Round_Constants(7));
    round_9: AES_round port map (r8, r9_in, k8, k9_in, '0', Round_Constants(8));
    last_round: AES_round port map (r9, DATA_OUT, k9, k10_in, '1', Round_Constants(9));
    
    -- subkey registers
    k1_reg : Reg port map (CLK_in, RESET_in, k1_in, k1_out);
    k2_reg : Reg port map (CLK_in, RESET_in, k2_in, k2_out);
    k3_reg : Reg port map (CLK_in, RESET_in, k3_in, k3_out);
    k4_reg : Reg port map (CLK_in, RESET_in, k4_in, k4_out);
    k5_reg : Reg port map (CLK_in, RESET_in, k5_in, k5_out);
    k6_reg : Reg port map (CLK_in, RESET_in, k6_in, k6_out);
    k7_reg : Reg port map (CLK_in, RESET_in, k7_in, k7_out);
    k8_reg : Reg port map (CLK_in, RESET_in, k8_in, k8_out);
    k9_reg : Reg port map (CLK_in, RESET_in, k9_in, k9_out);
    k10_reg : Reg port map (CLK_in, RESET_in, k10_in, k10_out);

    -- round result registers
    r1_reg : Reg port map (CLK_in, RESET_in, r1_in, r1_out);
    r2_reg : Reg port map (CLK_in, RESET_in, r2_in, r2_out);
    r3_reg : Reg port map (CLK_in, RESET_in, r3_in, r3_out);
    r4_reg : Reg port map (CLK_in, RESET_in, r4_in, r4_out);
    r5_reg : Reg port map (CLK_in, RESET_in, r5_in, r5_out);
    r6_reg : Reg port map (CLK_in, RESET_in, r6_in, r6_out);
    r7_reg : Reg port map (CLK_in, RESET_in, r7_in, r7_out);
    r8_reg : Reg port map (CLK_in, RESET_in, r8_in, r8_out);
    r9_reg : Reg port map (CLK_in, RESET_in, r9_in, r9_out);
    
    main_assignment : process(CLK_in)
    begin
        r1 <= r1_out;
        r2 <= r2_out;
        r3 <= r3_out;
        r4 <= r4_out;
        r5 <= r5_out;
        r6 <= r6_out;
        r7 <= r7_out;
        r8 <= r8_out;
        r9 <= r9_out;
        
        k1 <= k1_out;
        k2 <= k2_out;
        k3 <= k3_out;
        k4 <= k4_out;
        k5 <= k5_out;
        k6 <= k6_out;
        k7 <= k7_out;
        k8 <= k8_out;
        k9 <= k9_out;
        k10 <= k10_out;
    end process;
end TOP_architecture;
