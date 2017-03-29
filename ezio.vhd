LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY AC_REMOTE_CONTROLLER IS
    PORT(
        POWER: IN STD_LOGIC;                -- POWER ON OR POWER OFF THE AC
		  CLOCK: IN STD_LOGIC;                
		  TEMPUP: IN STD_LOGIC;               --INCREASE TEMPERATURE
        TEMPDOWN: IN STD_LOGIC;             --DECREASE TEMPERATURE
        SPEEDUP: IN STD_LOGIC;              --INCREASE FAN SPEED
        SPEEDDOWN: IN STD_LOGIC;            --DECREASE FAN SPEED
		  TURBO_MODE: IN STD_LOGIC;           --A MODE THAT COOLS ROOM FASTER
		  NORMAL_MODE: IN STD_LOGIC;           
		  EFFICIENT_MODE: IN STD_LOGIC;       --POWER SAVING MODE
		  SWING: IN STD_LOGIC;                --TO MAKE FLAPE SWING OR STOP SWINGING
		  SWING_VALUE: OUT STD_LOGIC;
        TEMPERATURE: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
        FANSPEED: OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END AC_REMOTE_CONTROLLER;
 
ARCHITECTURE LOGIC OF AC_REMOTE_CONTROLLER IS
 
BEGIN
   
    PROCESS (CLOCK) IS
    VARIABLE TEMP : INTEGER;
    VARIABLE SPEED : INTEGER;
	 VARIABLE SWING_VAL: STD_LOGIC;
   
    BEGIN
	   IF(POWER='0')THEN
	   SWING_VAL:='0';
		END IF;
     
	  IF (RISING_EDGE(CLOCK) AND POWER='1') THEN
        IF (NORMAL_MODE = '1') THEN
            TEMP:= 25;
            SPEED := 3;   
        ELSIF (TURBO_MODE = '1') THEN
            TEMP:= 22;
            SPEED :=6;   				
       
        ELSIF (TEMPUP = '1' AND TEMP < 38)THEN
            TEMP :=TEMP + 1;
        ELSIF (TEMPDOWN = '1' AND TEMP > 10) THEN
            TEMP := TEMP- 1;
        ELSIF (SPEEDUP = '1' AND SPEED < 7) THEN
            SPEED := SPEED + 1;
        ELSIF (SPEEDDOWN = '1' AND SPEED > 1) THEN
            SPEED := SPEED- 1;
		  ELSIF(SWING='1' AND SWING_VAL='1')THEN
		     SWING_VAL:='0';
		  ELSIF(SWING='1' AND SWING_VAL='0')THEN
		     SWING_VAL:='1';
        END IF;
        
		  SWING_VALUE<= SWING_VAL;
        TEMPERATURE <= CONV_STD_LOGIC_VECTOR(TEMP,6) AFTER 1 PS;
        FANSPEED <= CONV_STD_LOGIC_VECTOR (SPEED,3) AFTER 1 PS;
    
	 END IF;  
    END PROCESS;
 
END LOGIC;