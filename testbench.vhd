-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- components
component half_adder is
port(
  x,y: in std_logic;
  sum, carry: out std_logic);
end component;

signal x_in, y_in, Hs_out, Hc_out: std_logic;

component full_adder is
port(
  FA,FB,FCin: in std_logic;
  FS,FCout: out std_logic);
end component;

signal Fa_in, Fb_in, Fc_in, Fs_out, Fc_out: std_logic;

component ripple_adder_sub is
port(
  A, B: in std_logic_vector (3 downto 0);
  Cin: in std_logic;
  S: out std_logic_vector (3 downto 0);
  Cout: out std_logic);
end component;

signal Adda_in, Addb_in, Adds_out: std_logic_vector (3 downto 0);
signal Addc_in, Addc_out: std_logic;

signal Suba_in, Subb_in, Subs_out: std_logic_vector (3 downto 0);
signal Subc_in, Subc_out: std_logic;
constant period : time := 10 ns;

begin

  HA: half_adder port map(x_in, y_in, Hs_out, Hc_out);
  FA: full_adder port map(Fa_in, Fb_in, Fc_in, Fs_out, Fc_out);
  RAdd: ripple_adder_sub port map(Adda_in, Addb_in, Addc_in,  Adds_out, Addc_out);
  RSub: ripple_adder_sub port map(Suba_in, Subb_in, Subc_in,  Subs_out, Subc_out);

  -- half adder
  process
  begin
    x_in <= '0';
    y_in <= '0';
    wait for period;
    assert(Hs_out='0') report "Fail 0/0" severity error;
    assert(Hc_out='0') report "Fail 0/0" severity error;
  
    x_in <= '0';
    y_in <= '1';
    wait for period;
    assert(Hs_out='1') report "Fail 0/1" severity error;
    assert(Hc_out='0') report "Fail 0/1" severity error;

    x_in <= '1';
    y_in <= '0';
    wait for period;
    assert(Hs_out='1') report "Fail 1/0" severity error;
    assert(Hc_out='0') report "Fail 1/0" severity error;
    
    x_in <= '1';
    y_in <= '1';
    wait for period;
    assert(Hs_out='0') report "Fail 1/1" severity error;
    assert(Hc_out='1') report "Fail 1/1" severity error;
    
    -- Clear inputs
    x_in <= '0';
    y_in <= '0';

    assert false report "Test done." severity note;
    wait;
  end process;

  -- full adder
  process
  begin
    Fa_in <= '0';
    Fb_in <= '0';
    Fc_in <= '0';
    wait for period;
    assert(Fs_out='0') report "Fail 0/0/0" severity error;
    assert(Fc_out='0') report "Fail 0/0/0" severity error;
  
    Fa_in <= '0';
    Fb_in <= '0';
    Fc_in <= '1';
    wait for period;
    assert(Fs_out='1') report "Fail 0/0/1" severity error;
    assert(Fc_out='0') report "Fail 0/0/1" severity error;

    Fa_in <= '0';
    Fb_in <= '1';
    Fc_in <= '0';
    wait for period;
    assert(Fs_out='1') report "Fail 0/1/0" severity error;
    assert(Fc_out='0') report "Fail 0/1/0" severity error;
    
    Fa_in <= '0';
    Fb_in <= '1';
    Fc_in <= '1';
    wait for period;
    assert(Fs_out='0') report "Fail 0/1/1" severity error;
    assert(Fc_out='1') report "Fail 0/1/1" severity error;
    
    Fa_in <= '1';
    Fb_in <= '0';
    Fc_in <= '0';
    wait for period;
    assert(Fs_out='1') report "Fail 1/0/0" severity error;
    assert(Fc_out='0') report "Fail 1/0/0" severity error;
    
    Fa_in <= '1';
    Fb_in <= '0';
    Fc_in <= '1';
    wait for period;
    assert(Fs_out='0') report "Fail 1/0/1" severity error;
    assert(Fc_out='1') report "Fail 1/0/1" severity error;
    
    Fa_in <= '1';
    Fb_in <= '1';
    Fc_in <= '0';
    wait for period;
    assert(Fs_out='0') report "Fail 1/1/0" severity error;
    assert(Fc_out='1') report "Fail 1/1/0" severity error;
    
    Fa_in <= '1';
    Fb_in <= '1';
    Fc_in <= '1';
    wait for period;
    assert(Fs_out='1') report "Fail 1/1/1" severity error;
    assert(Fc_out='1') report "Fail 1/1/1" severity error;
    
    -- Clear inputs
    Fa_in <= '0';
    Fb_in <= '0';
    Fc_in <= '0';

    assert false report "Test done." severity note;
    wait;
  end process;
  
  -- ripple adder
  process
   begin  
      -- 0+0
      Adda_in <= "0000";
      Addb_in <= "0000";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="0000") report "Fail 0/0" severity error;
      assert(Addc_out='0') report "Fail 0/0" severity error;
      
      -- 1+2
      Adda_in <= "0001";
      Addb_in <= "0010";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="0011") report "Fail 1/2" severity error;
      assert(Addc_out='0') report "Fail 1/2" severity error;

      -- 5+6
      Adda_in <= "0101";
      Addb_in <= "0110";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1011") report "Fail 5/6" severity error;
      assert(Addc_out='0') report "Fail 5/6" severity error;
      
      -- 10+4
      Adda_in <= "1010";
      Addb_in <= "0100";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1110") report "Fail 10/40" severity error;
      assert(Addc_out='0') report "Fail 10/4" severity error;
      
      -- 7+8
      Adda_in <= "0111";
      Addb_in <= "1000";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1111") report "Fail 7/8" severity error;
      assert(Addc_out='0') report "Fail 7/8" severity error;
      
      -- 9+13
      Adda_in <= "1001";
      Addb_in <= "1101";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="0110") report "Fail 9/13" severity error;
      assert(Addc_out='1') report "Fail 9/13" severity error;
      
      -- 14+10
      Adda_in <= "1110";
      Addb_in <= "1010";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1000") report "Fail 14/10" severity error;
      assert(Addc_out='1') report "Fail 14/10" severity error;
      
      -- 12+4
      Adda_in <= "1100";
      Addb_in <= "0100";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="0000") report "Fail 12/4" severity error;
      assert(Addc_out='1') report "Fail 12/4" severity error;
      
      -- 14+13
      Adda_in <= "1110";
      Addb_in <= "1101";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1011") report "Fail 14/13" severity error;
      assert(Addc_out='1') report "Fail 14/13" severity error;
      
      -- 15+15
      Adda_in <= "1111";
      Addb_in <= "1111";
      Addc_in <= '0';
      wait for period;
      assert(Adds_out="1110") report "Fail 15/15" severity error;
      assert(Addc_out='1') report "Fail 15/15" severity error;
      
      -- Wait indefinitely. 
      wait;
   end process;
   
   -- ripple substractor
   process
   begin    
      --0-0
      Suba_in <= "0000";
      Subb_in <= "0000";
      Subc_in<= '1';
      wait for period;    
      assert (Subs_out = "0000") report "fail 0-0" severity error;
      assert (Subc_out = '1') report "fail 0-0" severity error;
      
      --5-3 
      Suba_in <= "0101";
      Subb_in <= "0011";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0010") report "fail 5-3" severity error;
      assert (Subc_out = '1') report "fail 5-3" severity error;
 
      -- 8-2
      Suba_in <= "1000";
      Subb_in <= "0010";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0110") report "fail 8-2" severity error;
      assert (Subc_out = '1') report "fail 8-2" severity error;
      
      --13-10
      Suba_in <= "1101";
      Subb_in <= "1010";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0011") report "fail 13-10" severity error;
      assert (Subc_out = '1') report "fail 13-10" severity error;
      
      --6-10
      Suba_in <= "0110";
      Subb_in <= "1010";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "1100") report "fail 6-10" severity error;
      assert (Subc_out = '0') report "fail 6-10" severity error;
      
      -- 15-9
      Suba_in <= "1111";
      Subb_in <= "1001";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0110") report "fail 15-9" severity error;
      assert (Subc_out = '1') report "fail 15-9" severity error;
      
      -- 5-2
      Suba_in <= "0101";
      Subb_in <= "0010";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0011") report "fail 5-2" severity error;
      assert (Subc_out = '1') report "fail 5-2" severity error;
      
      --12-8
      Suba_in <= "1100";
      Subb_in <= "1000";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0100") report "fail 12-8" severity error;
      assert (Subc_out = '1') report "fail 12-8" severity error;
      
      -- 7-2
      Suba_in <= "0111";
      Subb_in <= "0010";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0101") report "fail 7-2" severity error;
      assert (Subc_out = '1') report "fail 7-2" severity error; 
 
      -- 1-1
      Suba_in <= "0001";
      Subb_in <= "0001";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0000") report "fail 1-1" severity error;
      assert (Subc_out = '1') report "fail 1-1" severity error;

      -- 9-6
      Suba_in <= "1001";
      Subb_in <= "0110";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0011") report "fail 9-6" severity error;
      assert (Subc_out = '1') report "fail 9-6" severity error;

      -- 6-9
      Suba_in <= "0110";
      Subb_in <= "1001";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "1101") report "fail 6-9" severity error;
      assert (Subc_out = '0') report "fail 6-9" severity error;

      -- 14-7
      Suba_in <= "1110";
      Subb_in <= "0111";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "0111") report "fail 14-7" severity error;
      assert (Subc_out = '1') report "fail 14-7" severity error;
      
      -- 7-14
      Suba_in <= "0111";
      Subb_in <= "1110";
      Subc_in<= '1';
      wait for period;
      assert (Subs_out = "1001") report "fail 7-14" severity error;
      assert (Subc_out = '0') report "fail 7-14" severity error; 
   
      -- Wait indefinitely. 
      wait;
   end process;
end tb;