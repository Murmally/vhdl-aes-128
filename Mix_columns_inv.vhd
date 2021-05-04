-----------------------------------------------------------------------------
-- Module Name: Mix_columns_inv - Mix_columns_inv_architecture
-- Project Name: AES - Advanced Encryption Standard
-- Description: Component that performs the inverse mix columns operation.
-----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mix_columns_inv is
port (
    INPUT  : in std_logic_vector(127 downto 0);   -- input block
    OUTPUT : out std_logic_vector(127 downto 0)); -- output block
end Mix_columns_inv;

architecture Mix_columns_inv_architecture of Mix_columns_inv is
    type matrix_of_bytes is array (15 downto 0) of std_logic_vector(7 downto 0); 
    signal base_matrix, output_matrix : matrix_of_bytes;
    signal matrix_x9, matrix_x11, matrix_x13, matrix_x14 : matrix_of_bytes;
    
begin
    -- take the input and turn it to a base_matrix
    map_input: process(INPUT)
    begin
        for i in 15 downto 0 loop
           base_matrix(15-i) <= INPUT(8*i+7 downto 8*i);
        end loop;
    end process;
    
    -- multiply the entire input matrix by 9, preparation for mixing columns
    multiply_matrix_by9 : process(base_matrix)
        variable aux_1, aux_2, aux_3 : std_logic_vector(8 downto 0);
    begin
        for i in  15 downto 0 loop
            aux_1 := base_matrix(i) & '0';	
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_1(8)='1' then
               aux_1(7 downto 0) :=  aux_1(7 downto 0) xor "00011011";
            end if;
        
            aux_2 := aux_1(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_2(8)='1' then
                aux_2(7 downto 0) := aux_2(7 downto 0) xor "00011011";
            end if;
             
            aux_3 := aux_2(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_3(8)='1' then
                aux_3(7 downto 0) := aux_3(7 downto 0) xor "00011011";
            end if;
        
            matrix_x9(i) <= base_matrix(i) xor aux_3(7 downto 0);
        end loop;
    end process;
    
    -- multiply the entire input matrix by 11, preparation for mixing columns
    multiply_matrix_by11 : process(base_matrix)
        variable aux_1, aux_2, aux_3 : std_logic_vector(8 downto 0); 
    begin
        for i in  15 downto 0 loop
            aux_1 := base_matrix(i) & '0';	
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_1(8)='1' then
               aux_1(7 downto 0) :=  aux_1(7 downto 0) xor "00011011";
            end if;
        
            aux_2 := aux_1(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_2(8)='1' then
                aux_2(7 downto 0) := aux_2(7 downto 0) xor "00011011";
            end if;
             
            aux_3 :=  aux_2(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_3(8)='1' then
                aux_3(7 downto 0) := aux_3(7 downto 0) xor "00011011";
            end if;
             
            matrix_x11(i) <= base_matrix(i) xor aux_1(7 downto 0) xor aux_3(7 downto 0);
        end loop;
    end process;
    
    -- multiply the entire input matrix by 13, preparation for mixing columns 
    multiply_matrix_by13 : process(base_matrix)
        variable aux_1, aux_2, aux_3 : std_logic_vector(8 downto 0);
    begin
        for i in 15 downto 0 loop
            aux_1 := base_matrix(i) & '0';	
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_1(8)='1' then
               aux_1(7 downto 0) :=  aux_1(7 downto 0) xor "00011011";
            end if;
        
            aux_2 := aux_1(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_2(8)='1' then
                aux_2(7 downto 0) := aux_2(7 downto 0) xor "00011011";
            end if;
             
            aux_3 := aux_2(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_3(8)='1' then
                aux_3(7 downto 0) := aux_3(7 downto 0) XOR "00011011";
            end if;
        
            matrix_x13(i) <= base_matrix(i) xor aux_2(7 downto 0) xor aux_3(7 downto 0);
        end loop;
    end process;
    
    -- multiply the entire input matrix by 14, preparation for mixing columns
    multiply_matrix_by14 : process(base_matrix)
        variable aux_1, aux_2, aux_3 : std_logic_vector(8 downto 0);
    begin
        for i in  15 downto 0 loop
            aux_1 := base_matrix(i) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST	
            if aux_1(8)='1' then
               aux_1(7 downto 0) :=  aux_1(7 downto 0) xor "00011011";
            end if;
        
            aux_2 := aux_1(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_2(8)='1' then
                aux_2(7 downto 0) := aux_2(7 downto 0) xor "00011011";
            end if;
             
            aux_3 := aux_2(7 downto 0) & '0';
            -- in case the multiplied value is too big, Galois irreducible polynomial is applied as specified by NIST
            if aux_3(8)='1' then
                aux_3(7 downto 0) := aux_3(7 downto 0) xor "00011011";
            end if;
        
            matrix_x14(i) <= aux_1(7 downto 0) XOR aux_2(7 downto 0) xor aux_3(7 downto 0);
        end loop;
    end process;
    
    -- mixing columns
    -- first column
    output_matrix(0) <= matrix_x14(0) xor matrix_x11(1) xor matrix_x13(2) xor matrix_x9(3);
    output_matrix(1) <= matrix_x9(0) xor matrix_x14(1) xor matrix_x11(2) xor matrix_x13(3);
    output_matrix(2) <= matrix_x13(0) xor matrix_x9(1) xor matrix_x14(2) xor matrix_x11(3);
    output_matrix(3) <= matrix_x11(0) xor matrix_x13(1) xor matrix_x9(2) xor matrix_x14(3);
    
    -- second column
    output_matrix(4) <= matrix_x14(4) xor matrix_x11(5) xor matrix_x13(6) xor matrix_x9(7);
    output_matrix(5) <= matrix_x9(4) xor matrix_x14(5) xor matrix_x11(6) xor matrix_x13(7);
    output_matrix(6) <= matrix_x13(4) xor matrix_x9(5) xor matrix_x14(6) xor matrix_x11(7);
    output_matrix(7) <= matrix_x11(4) xor matrix_x13(5) xor matrix_x9(6) xor matrix_x14(7);

    -- third column
    output_matrix(8) <= matrix_x14(8) xor matrix_x11(9) xor matrix_x13(10) xor matrix_x9(11);
    output_matrix(9) <= matrix_x9(8) xor matrix_x14(9) xor matrix_x11(10) xor matrix_x13(11);
    output_matrix(10) <= matrix_x13(8) xor matrix_x9(9) xor matrix_x14(10) xor matrix_x11(11);
    output_matrix(11) <= matrix_x11(8) xor matrix_x13(9) xor matrix_x9(10) xor matrix_x14(11);
    
    -- fourth column
    output_matrix(12) <= matrix_x14(12) xor matrix_x11(13) xor matrix_x13(14) xor matrix_x9(15);
    output_matrix(13) <= matrix_x9(12) xor matrix_x14(13) xor matrix_x11(14) xor matrix_x13(15); 
    output_matrix(14) <= matrix_x13(12) xor matrix_x9(13) xor matrix_x14(14) xor matrix_x11(15);
    output_matrix(15) <= matrix_x11(12) xor matrix_x13(13) xor matrix_x9(14) xor matrix_x14(15);
    
    -- map matrix back to OUTPUT signal
    map_output : process(output_matrix)
    begin
        for i in 15 downto 0 loop
           OUTPUT(8*i+7 downto 8*i) <= output_matrix(15-i);
        end loop;
    end process;
end Mix_columns_inv_architecture;
