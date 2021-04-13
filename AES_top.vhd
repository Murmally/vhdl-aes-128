library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity AES_top is
port (
    CLK_in : in std_logic;
    RESET_in : in std_logic;
    READ_MEM_EN : out std_logic;
    WRITE_MEM_EN : out std_logic;
    DATA_IN : in std_logic_vector(127 downto 0);
    DATA_OUT : out std_logic_vector(127 downto 0);
    ADDR_READ : out std_logic_vector(31 downto 0);
    ADDR_WRITE : out std_logic_vector(31 downto 0);
    WRITE_READY : out std_logic_vector(15 downto 0);
    READ_READY : out std_logic_vector(15 downto 0));
end;

architecture Main_Architecture of AES_top is
  component AES_Round is
  port (
    DATA_IN : in std_logic_vector(127 downto 0);
    DATA_OUT : out std_logic_vector(127 downto 0);
    KEY_IN : in std_logic_vector(127 downto 0);
    KEY_OUT : inout std_logic_vector(127 downto 0);
    last_mux_sel : in std_logic;
    RCon : in std_logic_vector(7 downto 0));
  end component;
  
  type Round_Constant_Array is array (0 to 9) of std_logic_vector(7 downto 0);
  signal Round_Constants : Round_Constant_Array := (X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1B", X"36");

  signal Memory_IN_Address : std_logic_vector(31 downto 0) := X"40000000";
  signal Memory_OUT_Address : std_logic_vector(31 downto 0) := X"40000000";
  
  signal Secret_Key : std_logic_vector(127 downto 0) := X"5468617473206D79204B756E67204675";
  -- signal Message : std_logic_vector(127 downto 0) := X"54776F204F6E65204E696E652054776F";
  signal r1, r2, r3, r4, r5, r6, r7, r8, r9  : std_logic_vector(127 downto 0);
  signal k1, k2, k3, k4, k5, k6 ,k7, k8, k9, k10 : std_logic_vector(127 downto 0);
  signal Round_1_IN : std_logic_vector(127 downto 0);
  signal Final_Result : std_logic_vector(127 downto 0);
  
  signal Disable_Write : std_logic;
  signal Delay : std_logic;
begin
  
  
  
  -- DATA_IN; DATA_OUT; KEY_IN; KEY_OUT; last_mux_sel; RCon
  Round_1_IN <= Secret_Key xor DATA_IN;
  round_1: AES_Round port map (Round_1_IN, r1, Secret_Key, k1, '0', Round_Constants(0)); 
  round_2: AES_Round port map (r1, r2, k1, k2, '0', Round_Constants(1));
  round_3: AES_Round port map (r2, r3, k2, k3, '0', Round_Constants(2));
  round_4: AES_Round port map (r3, r4, k3, k4, '0', Round_Constants(3));
  round_5: AES_Round port map (r4, r5, k4, k5, '0', Round_Constants(4));
  round_6: AES_Round port map (r5, r6, k5, k6, '0', Round_Constants(5));
  round_7: AES_Round port map (r6, r7, k6, k7, '0', Round_Constants(6));
  round_8: AES_Round port map (r7, r8, k7, k8, '0', Round_Constants(7));
  round_9: AES_Round port map (r8, r9, k8, k9, '0', Round_Constants(8));
  last_round: AES_Round port map (r9, DATA_OUT, k9, k10, '1', Round_Constants(9));
  
end;
--  main_process: process(DATA_IN)
--    file outfile : text;
--    variable f_status : file_open_status;
--    variable row : line;
--  begin
--    file_open(f_status, outfile, "main_process_append.txt", append_mode);
--    write(row, string'("This process got triggered!"));
--    hwrite(row, DATA_IN);
--    Round_1_IN <= Secret_Key xor DATA_IN;
--    READ_READY <= (others => '0');
--    writeline(outfile, row);
--  end process;
  
--  write_process: process(k10)
--    file outfile : text;
--    variable f_status : file_open_status;
--    variable row : line;
--  begin
--    file_open(f_status, outfile, "write_process_append_k10.txt", append_mode);
--    write(row, string'("This process got triggered!"));
--    hwrite(row, Memory_IN_Address);
    
--    Memory_IN_Address <= std_logic_vector(unsigned(Memory_IN_Address) + 16);
--    ADDR_READ <= Memory_IN_Address;

--    Memory_OUT_Address <= std_logic_vector(unsigned(Memory_OUT_Address) + 16);
--    ADDR_WRITE <= Memory_OUT_Address;
--    READ_READY <= (others => '1');
--    WRITE_READY <= (others => '1');
--    Disable_Write <= '1';
--    writeline(outfile, row);
--  end process;
  
--  Disable_Write_proc: process(Disable_Write)
--  begin
--    if Disable_Write = '1' then
--        WRITE_READY <= (others => '0');
--        Disable_Write <= '0';
--    end if;
--  end process;
  
  
--  reset_proc : process(RESET_in)
--  begin
--    if RESET_in = '1' then
--        READ_MEM_EN <= '1';
--        WRITE_MEM_EN <= '1';
--        READ_READY <= (others => '1');
--        WRITE_READY <= (others => '0');
        
--        -- ADDR_READ <= X"40000000"; -- see Address Editor
--        -- ADDR_WRITE <= X"40000000";
--        Disable_Write <= '0';
--      end if;
--  end process;
--end;


--  test_proc: process(CLK_in)
--  begin
--  if rising_edge(CLK_in) then
--    Memory_IN_Address <= std_logic_vector(unsigned(Memory_IN_Address) + 16);
--    ADDR_READ <= Memory_IN_Address;
--  end if;
--  end process;


--  signal KeyGen_IN : std_logic_vector(127 downto 0);
--  signal KeyGen_OUT : std_logic_vector(127 downto 0);
--  signal KeyGenRCon_IN : std_logic_vector (7 downto 0);
  
--  signal INPUT : std_logic_vector(127 downto 0);
--  signal ROUND_KEY : std_logic_vector(127 downto 0);
--  signal last_mux_sel : std_logic;
--  signal OUTPUT : std_logic_vector(127 downto 0);
  
--  signal Round_Result : std_logic_vector(127 downto 0);
--  constant Wait_Time : time := 1ps;
  
    -- sem dat do sensitivity listu vsechny vstupy
  -- main: process
    --variable Secret_Key : std_logic_vector(127 downto 0) := X"5468617473206D79204B756E67204675";
    --variable Message : std_logic_vector(127 downto 0) := X"54776F204F6E65204E696E652054776F";
  --begin
    -- last_mux_sel <= '0';
    -- DONE <= '0';
    -- KeyGen_IN <= Secret_Key;
    -- KeyGenRCon_IN <= Round_Constants(0);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= Message xor Secret_Key;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(1);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(2);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(3);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(4);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(5);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(6);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(7);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(8);
    -- wait for Wait_Time;
    
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- KeyGen_IN <= KeyGen_OUT;
    -- KeyGenRCon_IN <= Round_Constants(9);
    -- wait for Wait_Time;
    
    -- last_mux_sel <= '1';
    -- ROUND_KEY <= KeyGen_OUT;
    -- INPUT <= OUTPUT;
    -- wait for Wait_Time;
    -- wait;
    -- DONE <= '1';
  -- end process;