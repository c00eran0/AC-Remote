LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY bot IS
END bot;
 
ARCHITECTURE behavior OF bot IS 
 
    COMPONENT AC_REMOTE_CONTROLLER
    PORT(
        POWER: IN STD_LOGIC;
		  CLOCK: IN STD_LOGIC;
		  TEMPUP: IN STD_LOGIC;
        TEMPDOWN: IN STD_LOGIC;
        SPEEDUP: IN STD_LOGIC;
        SPEEDDOWN: IN STD_LOGIC;
		  TURBO_MODE: IN STD_LOGIC;
		  NORMAL_MODE: IN STD_LOGIC;
		  EFFICIENT_MODE: IN STD_LOGIC;
		  SWING: IN STD_LOGIC;
		  SWING_VALUE: OUT STD_LOGIC;
        TEMPERATURE: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        FANSPEED: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;
   signal POWER : std_logic := '0'; 
   signal CLOCK : std_logic := '0';
   signal NORMAL_MODE : std_logic := '0';
	signal EFFICIENT_MODE : std_logic := '0';
	signal TURBO_MODE : std_logic := '0';
   signal TEMPUP : std_logic := '0';
   signal TEMPDOWN : std_logic := '0';
   signal SPEEDUP : std_logic := '0';
   signal SPEEDDOWN : std_logic := '0';
	signal SWING : std_logic := '0';
	signal SWING_VALUE : std_logic := '0';
	signal TEMPERATURE : std_logic_vector(5 downto 0);
   signal FANSPEED : std_logic_vector(2 downto 0);

   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
   uut: AC_REMOTE_CONTROLLER PORT MAP (
          CLOCK => CLOCK,
			 POWER=>POWER,
			 TEMPERATURE => TEMPERATURE, 
          FANSPEED => FANSPEED,
          TEMPUP => TEMPUP,
          TEMPDOWN => TEMPDOWN,
          SPEEDUP => SPEEDUP,
			 SPEEDDOWN => SPEEDDOWN,
			 SWING=>SWING,
			 SWING_VALUE=>SWING_VALUE,
			 TURBO_MODE=>TURBO_MODE,
			 EFFICIENT_MODE=>EFFICIENT_MODE,
			 NORMAL_MODE => NORMAL_MODE
          
        );

   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   stim_proc: process
   begin
	
	 wait for 10 ns;
	 POWER<='1';
	 wait for 10 ns;
    SWING<='1';
    wait for 10 ns;	
	 SWING<='0';
    SPEEDUP<='1';
    wait for 10 ns;
	 SPEEDUP<='0';
    TEMPUP<='1';
    WAIT FOR 10 NS;            	 --TEAM PROJECT BY HARDIK, ANUP, ABHISHEK--
    TEMPUP<='0';                                  
    WAIT FOR 50 NS;
    TEMPUP<='1';
    WAIT FOR 10 NS;
	 TEMPUP<='0';
	 WAIT FOR 50 NS;
	 NORMAL_MODE<='1';
	 WAIT FOR 10 NS;
	 NORMAL_MODE<='0';
	 SWING<='1';
	 WAIT FOR 10 NS;
	 SWING<='0';
	  WAIT FOR 50 NS;
	 TURBO_MODE<='1';
	 WAIT FOR 10 NS;
	 TURBO_MODE<='0';
	 WAIT FOR 50 NS;
	 EFFICIENT_MODE<='1';
	 WAIT FOR 50 NS;
	 TEMPDOWN<='1';
	 WAIT FOR 10 NS;
	 TEMPDOWN<='0';
	 SPEEDDOWN<='1';
	 WAIT FOR 10 NS;
	 SPEEDDOWN<='0';


wait;
end process;

END;
