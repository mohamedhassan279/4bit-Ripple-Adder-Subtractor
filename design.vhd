-- halfadder
--write your code here
-- Code your design here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity half_adder is
port(
  x,y: in std_logic;
  sum, carry: out std_logic);
end half_adder;

architecture arch of half_adder is
begin
  sum <= x xor y;
  carry <= x and y;
end arch;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity full_adder is
port(
  FA,FB,FCin: in std_logic;
  FS,FCout: out std_logic);
end full_adder;

architecture behave of full_adder is
component half_adder is
port(
  x,y: in std_logic;
  sum, carry: out std_logic);
end component;

signal S0, C0, C1: std_logic;

begin

HA0: half_adder port map (FA, FB, S0, C0);
HA1: half_adder port map (FCin, S0, FS, C1);
FCout <= C0 or C1;

end behave;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ripple_adder_sub is
port(
  A, B: in std_logic_vector (3 downto 0);
  Cin: in std_logic;
  S: out std_logic_vector (3 downto 0);
  Cout: out std_logic);
end ripple_adder_sub;

architecture struct of ripple_adder_sub is
component full_adder
port(
  FA,FB,FCin: in std_logic;
  FS,FCout: out std_logic);
end component;

signal Cout0, Cout1, Cout2: std_logic;

begin
FA0: full_adder port map(A(0), B(0) xor Cin, Cin, S(0), Cout0);
FA1: full_adder port map(A(1), B(1) xor Cin, Cout0, S(1), Cout1);
FA2: full_adder port map(A(2), B(2) xor Cin, Cout1, S(2), Cout2);
FA3: full_adder port map(A(3), B(3) xor Cin, Cout2, S(3), Cout);
end struct;