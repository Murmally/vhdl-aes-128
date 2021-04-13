library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity AES_top_tb is
end;

architecture bench of AES_top_tb is

  component AES_top
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
  end component;

  signal CLK_in: std_logic;
  signal RESET_in: std_logic;
  signal READ_MEM_EN: std_logic;
  signal WRITE_MEM_EN: std_logic;
  signal DATA_IN: std_logic_vector(127 downto 0);
  signal DATA_OUT: std_logic_vector(127 downto 0);
  signal ADDR_READ: std_logic_vector(31 downto 0);
  signal ADDR_WRITE: std_logic_vector(31 downto 0);
  signal WRITE_READY: std_logic_vector(15 downto 0);
  signal READ_READY: std_logic_vector(15 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: AES_top port map ( CLK_in       => CLK_in,
                          RESET_in     => RESET_in,
                          READ_MEM_EN  => READ_MEM_EN,
                          WRITE_MEM_EN => WRITE_MEM_EN,
                          DATA_IN      => DATA_IN,
                          DATA_OUT     => DATA_OUT,
                          ADDR_READ    => ADDR_READ,
                          ADDR_WRITE   => ADDR_WRITE,
                          WRITE_READY  => WRITE_READY,
                          READ_READY   => READ_READY );

  stimulus: process
  begin
    RESET_in <= '1';
    wait for clock_period;
    
    RESET_in <= '0';
    DATA_IN <= X"54776F204F6E65204E696E652054776F";
    
    wait for 500ns;
    DATA_IN <= X"31323334353637383930616263646566";
    wait for 500ns;
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK_in <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
end;
