LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- blinks when enable input is ON (e.g button press)

ENTITY led_control IS
    PORT (
        clk : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        led : OUT STD_LOGIC
    );
END ENTITY led_control;

ARCHITECTURE behavioral OF led_control IS
BEGIN
    PROCESS (clk) IS
    BEGIN
        IF rising_edge(clk) THEN
            IF enable = '1' THEN
                led <= '1';
            ELSE
                led <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE behavioral;