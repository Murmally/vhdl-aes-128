----------------------------------------------------------------------------------
-- Module Name: Mix_columns - Mix_columns_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Component that mixes columns for the input signal.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mix_columns is
port (
    INPUT  : in  std_logic_vector(127 downto 0);  -- input block
    OUTPUT : out std_logic_vector(127 downto 0)); -- output block
end Mix_columns;

architecture Mix_columns_architecture of Mix_columns is
    type matrix_of_bytes is array(15 downto 0) of std_logic_vector(7 downto 0); 
    type matrix_of_shifted_results is array(15 downto 0) of std_logic_vector(8 downto 0);
     
    signal shifted_matrix_1, shifted_matrix_2, reduced_result : matrix_of_shifted_results;
    signal base_matrix, output_matrix : matrix_of_bytes;
    signal matrix_x2, matrix_x3 : matrix_of_bytes;
begin
    -- take the input and turn it to a base_matrix
    map_input : process(INPUT)
    begin
        for i in 15 downto 0 loop
           base_matrix(15-i) <= INPUT(8*i+7 downto 8*i);
        end loop;
    end process;
    
    -- multiply the entire input matrix by 2, preparation for mixing columns
    multiply_matrix_by2 : process(base_matrix, shifted_matrix_1)
    begin
        for i in  15 downto 0 loop
            -- the multiplication itself
            shifted_matrix_1(i) <= base_matrix(i) & '0';
            
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if (shifted_matrix_1(i)(8) = '1') then
                matrix_x2(i) <= shifted_matrix_1(i)(7 downto 0) xor "00011011";
            else
                matrix_x2(i) <= shifted_matrix_1(i)(7 downto 0);
            end if;
        end loop;
    end process multiply_matrix_by2;
    
    --multiply the entire input matrix by 3, preparation for mixing columns
    multiply_matrix_by3 : process(base_matrix, shifted_matrix_2, reduced_result)
    begin
        for i in  15 downto 0 loop
            shifted_matrix_2(i) <= base_matrix(i) & '0';
            reduced_result(i) <= shifted_matrix_2(i) xor '0' & base_matrix(i);
        
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if (reduced_result(i)(8)='1') then    
                matrix_x3(i) <= reduced_result(i)(7 downto 0) xor "00011011";
            else
                matrix_x3(i) <= reduced_result(i)(7 downto 0);
            end if;
        end loop;
    end process multiply_matrix_by3;
    
    -- first column
    output_matrix(0) <= matrix_x2(0) xor matrix_x3(1) xor base_matrix(2) xor base_matrix(3);
    output_matrix(1) <= base_matrix(0) xor matrix_x2(1) xor matrix_x3(2) xor base_matrix(3);
    output_matrix(2) <= base_matrix(0) xor base_matrix(1) xor matrix_x2(2) xor matrix_x3(3);
    output_matrix(3) <= matrix_x3(0) xor base_matrix(1) xor base_matrix(2) xor matrix_x2(3);
    
    -- second column
    output_matrix(4) <= matrix_x2(4) xor matrix_x3(5) xor base_matrix(6) xor base_matrix(7);
    output_matrix(5) <= base_matrix(4) xor matrix_x2(5) xor matrix_x3(6) xor base_matrix(7);
    output_matrix(6) <= base_matrix(4) xor base_matrix(5) xor matrix_x2(6) xor matrix_x3(7);
    output_matrix(7) <= matrix_x3(4) xor base_matrix(5) xor base_matrix(6) xor matrix_x2(7);
    
    -- third column
    output_matrix(8) <= matrix_x2(8) xor matrix_x3(9) xor base_matrix(10) xor base_matrix(11);
    output_matrix(9) <= base_matrix(8) xor matrix_x2(9) xor matrix_x3(10) xor base_matrix(11);
    output_matrix(10) <= base_matrix(8) xor base_matrix(9) xor matrix_x2(10) xor matrix_x3(11);
    output_matrix(11) <= matrix_x3(8) xor base_matrix(9) xor base_matrix(10) xor matrix_x2(11);
    
    -- fourth column
    output_matrix(12) <= matrix_x2(12) xor matrix_x3(13) xor base_matrix(14) xor base_matrix(15);
    output_matrix(13) <= base_matrix(12) xor matrix_x2(13) xor matrix_x3(14) xor base_matrix(15); 
    output_matrix(14) <= base_matrix(12) xor base_matrix(13) xor matrix_x2(14) xor matrix_x3(15);
    output_matrix(15) <= matrix_x3(12) xor base_matrix(13) xor base_matrix(14) xor matrix_x2(15);
    
    map_output : process(output_matrix)
    begin
        for i in 15 downto 0 loop
           OUTPUT(8*i+7 downto 8*i) <= output_matrix(15-i);
        end loop;
    end process;
end Mix_columns_architecture;