----------------------------------------------------------------------------------
-- Module Name: Shift_rows_inv - Shift_rows_inv_architecture
-- Project Name: AES - Advanced Encryption Standard 
-- Description: Component that performs the inverse shift rows operation.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Shift_rows_inv is
port  (
    INPUT  : in std_logic_vector(127 downto 0);   -- input block
    OUTPUT : out std_logic_vector(127 downto 0)); -- output block
end Shift_rows_inv;

architecture Shift_rows_inv_architecture of Shift_rows_inv is
    type matrix_of_bytes is array(15 downto 0) of std_logic_vector(7 downto 0);
    signal input_matrix, output_matrix : matrix_of_bytes;
begin    
    -- map the 128 bit input to input_matrix so we can shift it.
    map_input: process(INPUT)
    begin
        for i in 15 downto 0 loop
           input_matrix(15 - i) <= INPUT(8*i + 7 downto 8*i);
        end loop;
    end process;
    
    -- first column
    output_matrix(0) <= input_matrix(0);
    output_matrix(1) <= input_matrix(13);
    output_matrix(2) <= input_matrix(10);
    output_matrix(3) <= input_matrix(7);
    
    -- second column
    output_matrix(4) <= input_matrix(4);
    output_matrix(5) <= input_matrix(1);
    output_matrix(6) <= input_matrix(14);
    output_matrix(7) <= input_matrix(11);
    
    -- third column
    output_matrix(8) <= input_matrix(8);
    output_matrix(9) <= input_matrix(5);
    output_matrix(10) <= input_matrix(2);
    output_matrix(11) <= input_matrix(15);
    
    -- forth column
    output_matrix(12) <= input_matrix(12);
    output_matrix(13) <= input_matrix(9);
    output_matrix(14) <= input_matrix(6);
    output_matrix(15) <= input_matrix(3);
    
    --map output_matrix back to 128 bit vector
    map_output: process(output_matrix)
    begin
        for i in 15 downto 0 loop
            OUTPUT(8*i + 7 downto 8*i) <= output_matrix(15-i);
        end loop;
    end process;
end Shift_rows_inv_architecture;
