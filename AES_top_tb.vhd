library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;

entity Test_all is
end;

architecture bench of Test_all is
  component TOP_decryption 
  port (
--      CLK_in : std_logic;
--      RESET_in : std_logic;
      INPUT : in std_logic_vector(127 downto 0);
      KEY : in std_logic_vector(127 downto 0);
      OUTPUT : out std_logic_vector(127 downto 0));
      -- X1, X2, X3, X4, X5, X6, X7, X8, X9, X10 : out std_logic_vector(127 downto 0));
  end component;

  signal INPUT: std_logic_vector(127 downto 0);
  signal KEY: std_logic_vector(127 downto 0);
  signal OUTPUT: std_logic_vector(127 downto 0);
  signal L1, L2, L3, L4, L5, L6, L7, L8, L9, L10 : std_logic_vector(127 downto 0);
  
  component TOP_encryption
  port (
      CLK_in : in std_logic;
      RESET_in : in std_logic;
      READ_MEM_EN : out std_logic;
      WRITE_MEM_EN : out std_logic;
      DATA_IN : in std_logic_vector(127 downto 0);
      KEY : in std_logic_vector(127 downto 0);
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
  signal ENC_KEY : std_logic_vector(127 downto 0);
  signal DATA_OUT: std_logic_vector(127 downto 0);
  signal ADDR_READ: std_logic_vector(31 downto 0);
  signal ADDR_WRITE: std_logic_vector(31 downto 0);
  signal WRITE_READY: std_logic_vector(15 downto 0);
  signal READ_READY: std_logic_vector(15 downto 0);

  constant clock_period: time := 3 ns;
  signal stop_the_clock: boolean;

begin

  encrypt: TOP_encryption port map ( CLK_in       => CLK_in,
                          RESET_in     => RESET_in,
                          READ_MEM_EN  => READ_MEM_EN,
                          WRITE_MEM_EN => WRITE_MEM_EN,
                          DATA_IN      => DATA_IN,
                          KEY => ENC_KEY,
                          DATA_OUT     => DATA_OUT,
                          ADDR_READ    => ADDR_READ,
                          ADDR_WRITE   => ADDR_WRITE,
                          WRITE_READY  => WRITE_READY,
                          READ_READY   => READ_READY );

  -- decrypt: TOP_decryption port map (CLK_in, RESET_in, INPUT, KEY, OUTPUT, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10);
  -- decrypt: TOP_decryption port map (INPUT, KEY, OUTPUT, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10);
  decrypt: TOP_decryption port map (INPUT, KEY, OUTPUT);
  clocking: process
  begin
        while not stop_the_clock loop
            CLK_in <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
  end process;

  stimulus: process
        file enc_out, dec_out : text;
        variable f_status : file_open_status;
        variable buffer_enc, buffer_dec : line;
  begin
        RESET_in <= '1';
        wait for clock_period;
        RESET_in <= '0';
        file_open(f_status, enc_out, "enc_out.txt", write_mode);
        file_open(f_status, dec_out, "dec_out.txt", write_mode);
		DATA_IN <= X"80000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"10a58869d74be5a374cf867cfb473859";
		INPUT <= X"6d251e6944b051e04eaa6fb4dbf78465";
		wait for clock_period;


		DATA_IN <= X"c0000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"caea65cdbb75e9169ecd22ebe6e54675";
		INPUT <= X"6e29201190152df4ee058139def610bb";
		wait for clock_period;


		DATA_IN <= X"e0000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"a2e2fa9baf7d20822ca9f0542f764a41";
		INPUT <= X"c3b44b95d9d2f25670eee9a0de099fa3";
		wait for clock_period;


		DATA_IN <= X"f0000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"b6364ac4e1de1e285eaf144a2415f7a0";
		INPUT <= X"5d9b05578fc944b3cf1ccf0e746cd581";
		wait for clock_period;


		DATA_IN <= X"f8000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"64cf9c7abc50b888af65f49d521944b2";
		INPUT <= X"f7efc89d5dba578104016ce5ad659c05";
		wait for clock_period;


		DATA_IN <= X"fc000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"47d6742eefcc0465dc96355e851b64d9";
		INPUT <= X"0306194f666d183624aa230a8b264ae7";
		wait for clock_period;


		DATA_IN <= X"fe000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"3eb39790678c56bee34bbcdeccf6cdb5";
		INPUT <= X"858075d536d79ccee571f7d7204b1f67";
		wait for clock_period;


		DATA_IN <= X"ff000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"64110a924f0743d500ccadae72c13427";
		INPUT <= X"35870c6a57e9e92314bcb8087cde72ce";
		wait for clock_period;


		DATA_IN <= X"ff800000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"18d8126516f8a12ab1a36d9f04d68e51";
		INPUT <= X"6c68e9be5ec41e22c825b7c7affb4363";
		wait for clock_period;


		DATA_IN <= X"ffc00000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"f530357968578480b398a3c251cd1093";
		INPUT <= X"f5df39990fc688f1b07224cc03e86cea";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffe00000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"da84367f325d42d601b4326964802e8e";
		INPUT <= X"bba071bcb470f8f6586e5d3add18bc66";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fff00000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"e37b1c6aa2846f6fdb413f238b089f23";
		INPUT <= X"43c9f7e62f5d288bb27aa40ef8fe1ea8";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fff80000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"6c002b682483e0cabcc731c253be5674";
		INPUT <= X"3580d19cff44f1014a7c966a69059de5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffc0000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"143ae8ed6555aba96110ab58893a8ae1";
		INPUT <= X"806da864dd29d48deafbe764f8202aef";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffe0000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"b69418a85332240dc82492353956ae0c";
		INPUT <= X"a303d940ded8f0baff6f75414cac5243";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffff0000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"71b5c08a1993e1362e4d0ce9b22b78d5";
		INPUT <= X"c2dabd117f8a3ecabfbb11d12194d9d0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffff8000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"e234cdca2606b81f29408d5f6da21206";
		INPUT <= X"fff60a4740086b3b9c56195b98d91a7b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffc000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"13237c49074a3da078dc1d828bb78c6f";
		INPUT <= X"8146a08e2357f0caa30ca8c94d1a0544";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffe000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"3071a2a48fe6cbd04f1a129098e308f8";
		INPUT <= X"4b98e06d356deb07ebb824e5713f7be3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffff000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"90f42ec0f68385f2ffc5dfc03a654dce";
		INPUT <= X"7a20a53d460fc9ce0423a7a0764c6cf2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffff800000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"febd9a24d8b65c1c787d50a4ed3619a9";
		INPUT <= X"f4a70d8af877f9b02b4c40df57d45b17";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffc00000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"80000000000000000000000000000000";
		INPUT <= X"0edd33d3c621e546455bd8ba1418bec8";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffe00000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"c0000000000000000000000000000000";
		INPUT <= X"4bc3f883450c113c64ca42e1112a9e87";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffff00000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"e0000000000000000000000000000000";
		INPUT <= X"72a1da770f5d7ac4c9ef94d822affd97";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffff80000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"f0000000000000000000000000000000";
		INPUT <= X"970014d634e2b7650777e8e84d03ccd8";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffc0000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"f8000000000000000000000000000000";
		INPUT <= X"f17e79aed0db7e279e955b5f493875a7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffe0000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fc000000000000000000000000000000";
		INPUT <= X"9ed5a75136a940d0963da379db4af26a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffff0000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fe000000000000000000000000000000";
		INPUT <= X"c4295f83465c7755e8fa364bac6a7ea5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffff8000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ff000000000000000000000000000000";
		INPUT <= X"b1d758256b28fd850ad4944208cf1155";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffc000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ff800000000000000000000000000000";
		INPUT <= X"42ffb34c743de4d88ca38011c990890b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffe000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffc00000000000000000000000000000";
		INPUT <= X"9958f0ecea8b2172c0c1995f9182c0f3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffff000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffe00000000000000000000000000000";
		INPUT <= X"956d7798fac20f82a8823f984d06f7f5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffff800000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fff00000000000000000000000000000";
		INPUT <= X"a01bf44f2d16be928ca44aaf7b9b106b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffc00000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fff80000000000000000000000000000";
		INPUT <= X"b5f1a33e50d40d103764c76bd4c6b6f8";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffe00000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffc0000000000000000000000000000";
		INPUT <= X"2637050c9fc0d4817e2d69de878aee8d";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffff00000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffe0000000000000000000000000000";
		INPUT <= X"113ecbe4a453269a0dd26069467fb5b5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffff80000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffff0000000000000000000000000000";
		INPUT <= X"97d0754fe68f11b9e375d070a608c884";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffc0000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffff8000000000000000000000000000";
		INPUT <= X"c6a0b3e998d05068a5399778405200b4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffe0000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffc000000000000000000000000000";
		INPUT <= X"df556a33438db87bc41b1752c55e5e49";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffff0000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffe000000000000000000000000000";
		INPUT <= X"90fb128d3a1af6e548521bb962bf1f05";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffff8000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffff000000000000000000000000000";
		INPUT <= X"26298e9c1db517c215fadfb7d2a8d691";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffc000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffff800000000000000000000000000";
		INPUT <= X"a6cb761d61f8292d0df393a279ad0380";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffe000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffc00000000000000000000000000";
		INPUT <= X"12acd89b13cd5f8726e34d44fd486108";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffff000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffe00000000000000000000000000";
		INPUT <= X"95b1703fc57ba09fe0c3580febdd7ed4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffff800000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffff00000000000000000000000000";
		INPUT <= X"de11722d893e9f9121c381becc1da59a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffc00000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffff80000000000000000000000000";
		INPUT <= X"6d114ccb27bf391012e8974c546d9bf2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffe00000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffc0000000000000000000000000";
		INPUT <= X"5ce37e17eb4646ecfac29b9cc38d9340";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffff00000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffe0000000000000000000000000";
		INPUT <= X"18c1b6e2157122056d0243d8a165cddb";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffff80000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffff0000000000000000000000000";
		INPUT <= X"99693e6a59d1366c74d823562d7e1431";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffc0000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffff8000000000000000000000000";
		INPUT <= X"6c7c64dc84a8bba758ed17eb025a57e3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffe0000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffc000000000000000000000000";
		INPUT <= X"e17bc79f30eaab2fac2cbbe3458d687a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffff0000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffe000000000000000000000000";
		INPUT <= X"1114bc2028009b923f0b01915ce5e7c4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffff8000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffff000000000000000000000000";
		INPUT <= X"9c28524a16a1e1c1452971caa8d13476";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffc000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffff800000000000000000000000";
		INPUT <= X"ed62e16363638360fdd6ad62112794f0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffe000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffc00000000000000000000000";
		INPUT <= X"5a8688f0b2a2c16224c161658ffd4044";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffff000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffe00000000000000000000000";
		INPUT <= X"23f710842b9bb9c32f26648c786807ca";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffff800000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffff00000000000000000000000";
		INPUT <= X"44a98bf11e163f632c47ec6a49683a89";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffc00000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffff80000000000000000000000";
		INPUT <= X"0f18aff94274696d9b61848bd50ac5e5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffe00000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffc0000000000000000000000";
		INPUT <= X"82408571c3e2424540207f833b6dda69";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffff00000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffe0000000000000000000000";
		INPUT <= X"303ff996947f0c7d1f43c8f3027b9b75";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffff80000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffff0000000000000000000000";
		INPUT <= X"7df4daf4ad29a3615a9b6ece5c99518a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffc0000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffff8000000000000000000000";
		INPUT <= X"c72954a48d0774db0b4971c526260415";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffe0000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffc000000000000000000000";
		INPUT <= X"1df9b76112dc6531e07d2cfda04411f0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffff0000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffe000000000000000000000";
		INPUT <= X"8e4d8e699119e1fc87545a647fb1d34f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffff8000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffff000000000000000000000";
		INPUT <= X"e6c4807ae11f36f091c57d9fb68548d1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffc000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffff800000000000000000000";
		INPUT <= X"8ebf73aad49c82007f77a5c1ccec6ab4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffe000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffc00000000000000000000";
		INPUT <= X"4fb288cc2040049001d2c7585ad123fc";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffff000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffe00000000000000000000";
		INPUT <= X"04497110efb9dceb13e2b13fb4465564";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffff800000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffff00000000000000000000";
		INPUT <= X"75550e6cb5a88e49634c9ab69eda0430";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffc00000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffff80000000000000000000";
		INPUT <= X"b6768473ce9843ea66a81405dd50b345";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffe00000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffc0000000000000000000";
		INPUT <= X"cb2f430383f9084e03a653571e065de6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffff00000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffe0000000000000000000";
		INPUT <= X"ff4e66c07bae3e79fb7d210847a3b0ba";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffff80000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffff0000000000000000000";
		INPUT <= X"7b90785125505fad59b13c186dd66ce3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffc0000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffff8000000000000000000";
		INPUT <= X"8b527a6aebdaec9eaef8eda2cb7783e5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffe0000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffc000000000000000000";
		INPUT <= X"43fdaf53ebbc9880c228617d6a9b548b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffff0000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffe000000000000000000";
		INPUT <= X"53786104b9744b98f052c46f1c850d0b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffff8000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffff000000000000000000";
		INPUT <= X"b5ab3013dd1e61df06cbaf34ca2aee78";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffc000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffff800000000000000000";
		INPUT <= X"7470469be9723030fdcc73a8cd4fbb10";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffe000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffc00000000000000000";
		INPUT <= X"a35a63f5343ebe9ef8167bcb48ad122e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffff000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffe00000000000000000";
		INPUT <= X"fd8687f0757a210e9fdf181204c30863";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffff800000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffff00000000000000000";
		INPUT <= X"7a181e84bd5457d26a88fbae96018fb0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffc00000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffff80000000000000000";
		INPUT <= X"653317b9362b6f9b9e1a580e68d494b5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffe00000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffc0000000000000000";
		INPUT <= X"995c9dc0b689f03c45867b5faa5c18d1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffff00000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffe0000000000000000";
		INPUT <= X"77a4d96d56dda398b9aabecfc75729fd";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffff80000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffff0000000000000000";
		INPUT <= X"84be19e053635f09f2665e7bae85b42d";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffc0000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffff8000000000000000";
		INPUT <= X"32cd652842926aea4aa6137bb2be2b5e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffe0000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffc000000000000000";
		INPUT <= X"493d4a4f38ebb337d10aa84e9171a554";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffff0000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffe000000000000000";
		INPUT <= X"d9bff7ff454b0ec5a4a2a69566e2cb84";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffff8000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffff000000000000000";
		INPUT <= X"3535d565ace3f31eb249ba2cc6765d7a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffc000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffff800000000000000";
		INPUT <= X"f60e91fc3269eecf3231c6e9945697c6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffe000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffc00000000000000";
		INPUT <= X"ab69cfadf51f8e604d9cc37182f6635a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffff000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffe00000000000000";
		INPUT <= X"7866373f24a0b6ed56e0d96fcdafb877";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffff800000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffff00000000000000";
		INPUT <= X"1ea448c2aac954f5d812e9d78494446a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffc00000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffff80000000000000";
		INPUT <= X"acc5599dd8ac02239a0fef4a36dd1668";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffe00000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffc0000000000000";
		INPUT <= X"d8764468bb103828cf7e1473ce895073";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffff00000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffe0000000000000";
		INPUT <= X"1b0d02893683b9f180458e4aa6b73982";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffff80000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffff0000000000000";
		INPUT <= X"96d9b017d302df410a937dcdb8bb6e43";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffc0000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffff8000000000000";
		INPUT <= X"ef1623cc44313cff440b1594a7e21cc6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffe0000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffc000000000000";
		INPUT <= X"284ca2fa35807b8b0ae4d19e11d7dbd7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffff0000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffe000000000000";
		INPUT <= X"f2e976875755f9401d54f36e2a23a594";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffff8000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffff000000000000";
		INPUT <= X"ec198a18e10e532403b7e20887c8dd80";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffc000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffff800000000000";
		INPUT <= X"545d50ebd919e4a6949d96ad47e46a80";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffe000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffc00000000000";
		INPUT <= X"dbdfb527060e0a71009c7bb0c68f1d44";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffff000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffe00000000000";
		INPUT <= X"9cfa1322ea33da2173a024f2ff0d896d";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffff800000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffff00000000000";
		INPUT <= X"8785b1a75b0f3bd958dcd0e29318c521";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffc00000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffff80000000000";
		INPUT <= X"38f67b9e98e4a97b6df030a9fcdd0104";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffe00000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffc0000000000";
		INPUT <= X"192afffb2c880e82b05926d0fc6c448b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffff00000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffe0000000000";
		INPUT <= X"6a7980ce7b105cf530952d74daaf798c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffff80000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffff0000000000";
		INPUT <= X"ea3695e1351b9d6858bd958cf513ef6c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffc0000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffff8000000000";
		INPUT <= X"6da0490ba0ba0343b935681d2cce5ba1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffe0000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffc000000000";
		INPUT <= X"f0ea23af08534011c60009ab29ada2f1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffff0000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffe000000000";
		INPUT <= X"ff13806cf19cc38721554d7c0fcdcd4b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffff8000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffff000000000";
		INPUT <= X"6838af1f4f69bae9d85dd188dcdf0688";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffc000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffff800000000";
		INPUT <= X"36cf44c92d550bfb1ed28ef583ddf5d7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffe000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffc00000000";
		INPUT <= X"d06e3195b5376f109d5c4ec6c5d62ced";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffff000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffe00000000";
		INPUT <= X"c440de014d3d610707279b13242a5c36";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffff800";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffff00000000";
		INPUT <= X"f0c5c6ffa5e0bd3a94c88f6b6f7c16b9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffc00";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffff80000000";
		INPUT <= X"3e40c3901cd7effc22bffc35dee0b4d9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffe00";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffc0000000";
		INPUT <= X"b63305c72bedfab97382c406d0c49bc6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffff00";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffe0000000";
		INPUT <= X"36bbaab22a6bd4925a99a2b408d2dbae";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffff80";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffff0000000";
		INPUT <= X"307c5b8fcd0533ab98bc51e27a6ce461";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffffc0";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffff8000000";
		INPUT <= X"829c04ff4c07513c0b3ef05c03e337b5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffffe0";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffc000000";
		INPUT <= X"f17af0e895dda5eb98efc68066e84c54";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffff0";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffe000000";
		INPUT <= X"277167f3812afff1ffacb4a934379fc3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffff8";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffff000000";
		INPUT <= X"2cb1dc3a9c72972e425ae2ef3eb597cd";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffffc";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffff800000";
		INPUT <= X"36aeaa3a213e968d4b5b679d3a2c97fe";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"fffffffffffffffffffffffffffffffe";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffc00000";
		INPUT <= X"9241daca4fdd034a82372db50e1a0f3f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"ffffffffffffffffffffffffffffffff";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffe00000";
		INPUT <= X"c14574d9cd00cf2b5a7f77e53cd57885";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"80000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffff00000";
		INPUT <= X"793de39236570aba83ab9b737cb521c9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"c0000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffff80000";
		INPUT <= X"16591c0f27d60e29b85a96c33861a7ef";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"e0000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffc0000";
		INPUT <= X"44fb5c4d4f5cb79be5c174a3b1c97348";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"f0000000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffe0000";
		INPUT <= X"674d2b61633d162be59dde04222f4740";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"f8000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffff0000";
		INPUT <= X"b4750ff263a65e1f9e924ccfd98f3e37";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fc000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffff8000";
		INPUT <= X"62d0662d6eaeddedebae7f7ea3a4f6b6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fe000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffc000";
		INPUT <= X"70c46bb30692be657f7eaa93ebad9897";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ff000000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffe000";
		INPUT <= X"323994cfb9da285a5d9642e1759b224a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ff800000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffff000";
		INPUT <= X"1dbf57877b7b17385c85d0b54851e371";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffc00000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffff800";
		INPUT <= X"dfa5c097cdc1532ac071d57b1d28d1bd";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffe00000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffc00";
		INPUT <= X"3a0c53fa37311fc10bd2a9981f513174";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fff00000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffe00";
		INPUT <= X"ba4f970c0a25c41814bdae2e506be3b4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fff80000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffff00";
		INPUT <= X"2dce3acb727cd13ccd76d425ea56e4f6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffc0000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffff80";
		INPUT <= X"5160474d504b9b3eefb68d35f245f4b3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffe0000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffffc0";
		INPUT <= X"41a8a947766635dec37553d9a6c0cbb7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffff0000000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffffe0";
		INPUT <= X"25d6cfe6881f2bf497dd14cd4ddf445b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffff8000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffff0";
		INPUT <= X"41c78c135ed9e98c096640647265da1e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffc000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffff8";
		INPUT <= X"5a4d404d8917e353e92a21072c3b2305";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffe000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffffc";
		INPUT <= X"02bc96846b3fdc71643f384cd3cc3eaf";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffff000000000000000000000000000";
		KEY <= X"fffffffffffffffffffffffffffffffe";
		INPUT <= X"9ba4a9143f4e5d4048521c4f8877d88e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffff800000000000000000000000000";
		KEY <= X"ffffffffffffffffffffffffffffffff";
		INPUT <= X"a1f6258c877d5fcd8964484538bfc92c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffc00000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3ad78e726c1ec02b7ebfe92b23d9ec34";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffe00000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"aae5939c8efdf2f04e60b9fe7117b2c2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffff00000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f031d4d74f5dcbf39daaf8ca3af6e527";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffff80000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"96d9fd5cc4f07441727df0f33e401a36";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffc0000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"30ccdb044646d7e1f3ccea3dca08b8c0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffe0000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"16ae4ce5042a67ee8e177b7c587ecc82";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffff0000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b6da0bb11a23855d9c5cb1b4c6412e0a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffff8000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"db4f1aa530967d6732ce4715eb0ee24b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffc000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a81738252621dd180a34f3455b4baa2f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffe000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"77e2b508db7fd89234caf7939ee5621a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffff000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b8499c251f8442ee13f0933b688fcd19";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffff800000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"965135f8a81f25c9d630b17502f68e53";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffc00000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"8b87145a01ad1c6cede995ea3670454f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffe00000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"8eae3b10a0c8ca6d1d3b0fa61e56b0b2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffff00000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"64b4d629810fda6bafdf08f3b0d8d2c5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffff80000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"d7e5dbd3324595f8fdc7d7c571da6c2a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffc0000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f3f72375264e167fca9de2c1527d9606";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffe0000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"8ee79dd4f401ff9b7ea945d86666c13b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffff0000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"dd35cea2799940b40db3f819cb94c08b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffff8000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"6941cb6b3e08c2b7afa581ebdd607b87";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffc000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"2c20f439f6bb097b29b8bd6d99aad799";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffe000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"625d01f058e565f77ae86378bd2c49b3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffff000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"c0b5fd98190ef45fbb4301438d095950";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffff800000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"13001ff5d99806efd25da34f56be854b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffc00000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3b594c60f5c8277a5113677f94208d82";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffe00000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"e9c0fc1818e4aa46bd2e39d638f89e05";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffff00000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f8023ee9c3fdc45a019b4e985c7e1a54";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffff80000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"35f40182ab4662f3023baec1ee796b57";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffc0000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3aebbad7303649b4194a6945c6cc3694";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffe0000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a2124bea53ec2834279bed7f7eb0f938";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffff0000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b9fb4399fa4facc7309e14ec98360b0a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffff8000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"c26277437420c5d634f715aea81a9132";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffc000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"171a0e1b2dd424f0e089af2c4c10f32f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffe000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7cadbe402d1b208fe735edce00aee7ce";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffff000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"43b02ff929a1485af6f5c6d6558baa0f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffff800000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"092faacc9bf43508bf8fa8613ca75dea";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffc00000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"cb2bf8280f3f9742c7ed513fe802629c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffe00000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"215a41ee442fa992a6e323986ded3f68";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffff00000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f21e99cf4f0f77cea836e11a2fe75fb1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffff80000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"95e3a0ca9079e646331df8b4e70d2cd6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffc0000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"4afe7f120ce7613f74fc12a01a828073";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffe0000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"827f000e75e2c8b9d479beed913fe678";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffff0000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"35830c8e7aaefe2d30310ef381cbf691";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffff8000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"191aa0f2c8570144f38657ea4085ebe5";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffc000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"85062c2c909f15d9269b6c18ce99c4f0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffe000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"678034dc9e41b5a560ed239eeab1bc78";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffff000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"c2f93a4ce5ab6d5d56f1b93cf19911c1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffff800000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1c3112bcb0c1dcc749d799743691bf82";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffc00000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"00c55bd75c7f9c881989d3ec1911c0d4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffe00000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"ea2e6b5ef182b7dff3629abd6a12045f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffff00000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"22322327e01780b17397f24087f8cc6f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffff80000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"c9cacb5cd11692c373b2411768149ee7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffc0000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a18e3dbbca577860dab6b80da3139256";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffe0000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"79b61c37bf328ecca8d743265a3d425c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffff0000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"d2d99c6bcc1f06fda8e27e8ae3f1ccc7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffff8000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1bfd4b91c701fd6b61b7f997829d663b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffc000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"11005d52f25f16bdc9545a876a63490a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffe000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3a4d354f02bb5a5e47d39666867f246a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffff000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"d451b8d6e1e1a0ebb155fbbf6e7b7dc3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffff800000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"6898d4f42fa7ba6a10ac05e87b9f2080";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffc00000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b611295e739ca7d9b50f8e4c0e754a3f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffe00000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7d33fc7d8abe3ca1936759f8f5deaf20";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffff00000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3b5e0f566dc96c298f0c12637539b25c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffff80000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f807c3e7985fe0f5a50e2cdb25c5109e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffc0000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"41f992a856fb278b389a62f5d274d7e9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffe0000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"10d3ed7a6fe15ab4d91acbc7d0767ab1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffff0000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"21feecd45b2e675973ac33bf0c5424fc";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffff8000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1480cb3955ba62d09eea668f7c708817";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffc000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"66404033d6b72b609354d5496e7eb511";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffe000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1c317a220a7d700da2b1e075b00266e1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffff000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"ab3b89542233f1271bf8fd0c0f403545";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffff800000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"d93eae966fac46dca927d6b114fa3f9e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffc00000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1bdec521316503d9d5ee65df3ea94ddf";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffe00000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"eef456431dea8b4acf83bdae3717f75f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffff00000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"06f2519a2fafaa596bfef5cfa15c21b9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffff80000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"251a7eac7e2fe809e4aa8d0d7012531a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffc0000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3bffc16e4c49b268a20f8d96a60b4058";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffe0000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"e886f9281999c5bb3b3e8862e2f7c988";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffff0000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"563bf90d61beef39f48dd625fcef1361";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffff8000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"4d37c850644563c69fd0acd9a049325b";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffc000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b87c921b91829ef3b13ca541ee1130a6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffe000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"2e65eb6b6ea383e109accce8326b0393";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffff000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"9ca547f7439edc3e255c0f4d49aa8990";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffff800000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a5e652614c9300f37816b1f9fd0c87f9";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffc00000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"14954f0b4697776f44494fe458d814ed";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffe00000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7c8d9ab6c2761723fe42f8bb506cbcf7";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffff00000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"db7e1932679fdd99742aab04aa0d5a80";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffff80000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"4c6a1c83e568cd10f27c2d73ded19c28";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffc0000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"90ecbe6177e674c98de412413f7ac915";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffe0000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"90684a2ac55fe1ec2b8ebd5622520b73";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffff0000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7472f9a7988607ca79707795991035e6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffff8000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"56aff089878bf3352f8df172a3ae47d8";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffc000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"65c0526cbe40161b8019a2a3171abd23";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffe000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"377be0be33b4e3e310b4aabda173f84f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffff000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"9402e9aa6f69de6504da8d20c4fcaa2f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffff800";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"123c1f4af313ad8c2ce648b2e71fb6e1";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffc00";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"1ffc626d30203dcdb0019fb80f726cf4";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffe00";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"76da1fbe3a50728c50fd2e621b5ad885";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffff00";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"082eb8be35f442fb52668e16a591d1d6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffff80";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"e656f9ecf5fe27ec3e4a73d00c282fb3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffffc0";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"2ca8209d63274cd9a29bb74bcd77683a";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffffe0";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"79bf5dce14bb7dd73a8e3611de7ce026";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffff0";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3c849939a5d29399f344c4a0eca8a576";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffff8";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"ed3c0a94d59bece98835da7aa4f07ca2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffffc";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"63919ed4ce10196438b6ad09d99cd795";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"fffffffffffffffffffffffffffffffe";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7678f3a833f19fea95f3c6029e2bc610";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"ffffffffffffffffffffffffffffffff";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3aa426831067d36b92be7c5f81c13c56";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"10a58869d74be5a374cf867cfb473859";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"9272e2d2cdd11050998c845077a30ea0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"00000000000000000000000000000000";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"088c4b53f5ec0ff814c19adae7f6246c";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"a2e2fa9baf7d20822ca9f0542f764a41";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"4010a5e401fdf0a0354ddbcc0d012b17";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"b6364ac4e1de1e285eaf144a2415f7a0";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a87a385736c0a6189bd6589bd8445a93";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"64cf9c7abc50b888af65f49d521944b2";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"545f2b83d9616dccf60fa9830e9cd287";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"47d6742eefcc0465dc96355e851b64d9";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"4b706f7f92406352394037a6d4f4688d";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"3eb39790678c56bee34bbcdeccf6cdb5";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"b7972b3941c44b90afa7b264bfba7387";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"64110a924f0743d500ccadae72c13427";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"6f45732cf10881546f0fd23896d2bb60";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"18d8126516f8a12ab1a36d9f04d68e51";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"2e3579ca15af27f64b3c955a5bfc30ba";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"f530357968578480b398a3c251cd1093";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"34a2c5a91ae2aec99b7d1b5fa6780447";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"da84367f325d42d601b4326964802e8e";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"a4d6616bd04f87335b0e53351227a9ee";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"e37b1c6aa2846f6fdb413f238b089f23";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"7f692b03945867d16179a8cefc83ea3f";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"6c002b682483e0cabcc731c253be5674";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3bd141ee84a0e6414a26e7a4f281f8a2";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"143ae8ed6555aba96110ab58893a8ae1";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"d1788f572d98b2b16ec5d5f3922b99bc";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"b69418a85332240dc82492353956ae0c";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"0833ff6f61d98a57b288e8c3586b85a6";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"71b5c08a1993e1362e4d0ce9b22b78d5";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"8568261797de176bf0b43becc6285afb";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"e234cdca2606b81f29408d5f6da21206";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"f9b0fda0c4a898f5b9e6f661c4ce4d07";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"13237c49074a3da078dc1d828bb78c6f";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"8ade895913685c67c5269f8aae42983e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"3071a2a48fe6cbd04f1a129098e308f8";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"39bde67d5c8ed8a8b1c37eb8fa9f5ac0";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"90f42ec0f68385f2ffc5dfc03a654dce";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"5c005e72c1418c44f569f2ea33ba54f3";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		DATA_IN <= X"00000000000000000000000000000000";
		ENC_KEY <= X"febd9a24d8b65c1c787d50a4ed3619a9";
		KEY <= X"00000000000000000000000000000000";
		INPUT <= X"3f5b8cc9ea855a0afa7347d23e8d664e";
		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		wait for clock_period;
		hwrite(buffer_enc, DATA_OUT);
		hwrite(buffer_dec, OUTPUT);
		writeline(enc_out, buffer_enc);
		writeline(dec_out, buffer_dec);

		stop_the_clock <= true;
		wait;
	end process;
end;
