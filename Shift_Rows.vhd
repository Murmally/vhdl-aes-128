library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftRows is
port (
	INPUT : in std_logic_vector(127 downto 0);
	OUTPUT: out std_logic_vector(127 downto 0));
end ShiftRows;

architecture ShiftRows_architecture of ShiftRows is
	type matrix_index is array (15 downto 0) of std_logic_vector(7 downto 0);
    SIGNAL matrix1, matrix2 : matrix_index;
begin

-- map the 128 bit input to matrix1 so we can shift it.
map_input: process(INPUT)
begin
    for i in 15 downto 0 loop
        matrix1(15-i) <= INPUT(8*i+7 downto 8*i);
    end loop;
end process map_input;

-- matrix2 is actually matrix1 shifted as shown in the above example.

-- combinatorial logic

-- first column
matrix2(0) <= matrix1(0);
matrix2(1) <= matrix1(5);
matrix2(2) <= matrix1(10);
matrix2(3) <= matrix1(15);
-- second column
matrix2(4) <= matrix1(4);
matrix2(5) <= matrix1(9);
matrix2(6) <= matrix1(14);
matrix2(7) <= matrix1(3);
-- third column
matrix2(8) <= matrix1(8);
matrix2(9) <= matrix1(13);
matrix2(10) <= matrix1(2);
matrix2(11) <= matrix1(7);
-- forth column
matrix2(12) <= matrix1(12);
matrix2(13) <= matrix1(1);
matrix2(14) <= matrix1(6);
matrix2(15) <= matrix1(11);

--map matrix2 back to 128 bit vector
map_output: process(matrix2)
begin
    for i in 15 downto 0 loop
	   OUTPUT(8*i+7 downto 8*i) <= matrix2(15-i);
    end loop;
end process map_output;

end ShiftRows_architecture;
