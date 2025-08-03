library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MovingAverage_tb is
end MovingAverage_tb;

architecture behavior of MovingAverage_tb is

    component MovingAverage
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            signal_in   : in  STD_LOGIC_VECTOR(5 downto 0);
            average_out : out STD_LOGIC
        );
    end component;

    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '1';
    signal signal_in   : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
    signal average_out : STD_LOGIC;

begin

    uut: MovingAverage
        Port map (
            clk => clk,
            reset => reset,
            signal_in => signal_in,
            average_out => average_out
        );

    -- Clock generation
    clk_process :process
    begin
        while True loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        -- Hold reset
        wait for 20 ns;
        reset <= '0';

        -- Test pattern: seat occupancy changing over time
        -- Cycle 1: 2 seats occupied
        signal_in <= "011011";
        wait for 20 ns;

        -- Cycle 2: 4 seats occupied
        signal_in <= "001111";
        wait for 20 ns;

        -- Cycle 3: 1 seat occupied
        signal_in <= "000001";
        wait for 20 ns;

        -- Cycle 4: 5 seats occupied
        signal_in <= "111110";
        wait for 20 ns;

        -- Hold
        wait for 20 ns;

        -- Stop simulation
        wait;
    end process;

end behavior;
