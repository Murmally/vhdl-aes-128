library ieee;
use ieee.std_logic_1164.ALL;

entity Encryption_Round is
port(
    INPUT        :	in  std_logic_vector(127 downto 0);
    ROUND_KEY	 :	in  std_logic_vector(127 downto 0);
    last_mux_sel :	in  std_logic;
    OUTPUT       :	out std_logic_vector(127 downto 0));
end Encryption_Round;

architecture Encryption_Round_architecture OF Encryption_Round IS
    component SBox
    port(
        INPUT    :	in  std_logic_vector(7 downto 0);
        OUTPUT   :	out std_logic_vector(7 downto 0));
    end component;
    
    component ShiftRows 
    port(
        INPUT     :   in  std_logic_vector(127 downto 0);
        OUTPUT    :   out std_logic_vector(127 downto 0));
    end component;
    
    component MixColumns 
    port(
        mixcolumn_in  :   in  std_logic_vector(127 downto 0);
        mixcolumn_out :   out std_logic_vector(127 downto 0));
    end component;
    
    signal shiftrow  : std_logic_vector(127 downto 0);
    signal bytesub   : std_logic_vector(127 downto 0);
    signal mixcolumn : std_logic_vector(127 downto 0);
    signal mux       : std_logic_vector(127 downto 0);
begin
    sbox_gen: for i in 15 downto 0 generate
        sbox_map: SBox
        port map(
            INPUT => INPUT(8*i+7 downto 8*i),
            OUTPUT => bytesub(8*i+7 downto 8*i));
    end generate sbox_gen;
    
    shiftrow_map:  ShiftRows
    port map(INPUT => bytesub, OUTPUT => shiftrow);
    
    mixcolumn_map: MixColumns
    port map(mixcolumn_in => shiftrow, mixcolumn_out => mixcolumn);
    
    -- in case last_mux_sel is 1, it's the last round
    mux <= mixcolumn when last_mux_sel ='0' else shiftrow;
    OUTPUT <= mux xor ROUND_KEY;
end Encryption_Round_architecture;