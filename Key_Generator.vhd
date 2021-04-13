library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity KeyGenerator is
    Port ( INPUT  :in  STD_LOGIC_VECTOR (127 downto 0);
           rcon  :  in  STD_LOGIC_VECTOR (7 downto 0);
           OUTPUT  :  out  STD_LOGIC_VECTOR (127 downto 0));
end KeyGenerator;

architecture Behavioral of KeyGenerator is

--signal k0,k1,k2,k3 : std_logic_vector(31 downto 0);
signal w0,w1,w2,w3 : std_logic_vector(31 downto 0);
signal x0,x1,x2,x3: std_logic_vector(31 downto 0);
signal temp,rcon_xor :std_logic_vector(31 downto 0);
signal  m,shift : std_logic_vector(31 downto 0);

component Sbox is
port (
    INPUT : in std_logic_vector(7 downto 0);
    OUTPUT : out std_logic_vector(7 downto 0));
end component;
begin
  temp <= INPUT(31 downto 0);
  w0 <= INPUT(127 downto 96);
  w1 <=INPUT(95 downto 64);
  w2 <=INPUT(63 downto 32);
  w3 <=INPUT(31 downto 0);

  shift <= temp(23 downto 0) & temp(31 downto 24);

  e1:Sbox port map(INPUT => shift(7  downto 0), OUTPUT => m(7  downto 0));
  e2:Sbox port map(INPUT => shift(15  downto 8), OUTPUT => m(15  downto 8));
  e3:Sbox port map(INPUT => shift(23  downto 16),OUTPUT => m(23  downto 16));
  e4:Sbox port map(INPUT => shift(31  downto 24), OUTPUT => m(31  downto 24));

  rcon_xor <= (m(31 downto 24) xor rcon) & m(23  downto 0);

  x0 <= (rcon_xor(31 downto 24) xor  w0(31 downto 24)) & (rcon_xor(23  downto 16) xor w0(23  downto 16)) & (rcon_xor(15  downto 8) xor w0(15  downto 8)) & (rcon_xor(7  downto 0) xor w0(7  downto 0));
  x1 <= (x0(31 downto 24) xor w1(31 downto 24))& (x0(23  downto 16) xor w1(23  downto 16)) & (x0(15  downto 8) xor w1(15  downto 8))& (x0(7  downto 0) xor w1(7  downto 0)) ;
  x2 <= (x1(31 downto 24) xor w2(31 downto 24)) & (x1(23  downto 16) xor w2(23  downto 16)) & (x1(15  downto 8) xor w2(15  downto 8)) & (x1(7  downto 0) xor  w2(7  downto 0)) ;
  x3 <= (x2(31 downto 24) xor w3(31 downto 24)) & (x2(23  downto 16) xor w3(23  downto 16))&(x2(15  downto 8) xor w3(15  downto 8))& (x2(7  downto 0) xor w3(7  downto 0)) ;
  OUTPUT <= x0 & x1 & x2 & x3;
end Behavioral;
