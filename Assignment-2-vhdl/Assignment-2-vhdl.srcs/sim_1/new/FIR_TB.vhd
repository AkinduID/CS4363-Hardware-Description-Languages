library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fir_tb is
-- no ports
end fir_tb;

architecture Behavioral of fir_tb is

    signal clk    : std_logic := '0';
    signal reset  : std_logic := '1';
    signal x_in   : signed(15 downto 0) := (others => '0');
    signal y_out  : signed(31 downto 0);

begin

    -- Instantiate FIR filter
    uut: entity work.fir_filter
        port map(
            clk => clk,
            reset => reset,
            x_in => x_in,
            y_out => y_out
        );

    -- Clock generation: 100 MHz (10 ns period)
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus
    stim_proc : process
    begin
        -- reset first
        wait for 20 ns;
        reset <= '0';

        -- input samples
        x_in <= to_signed(100,16); wait for 100 ns;
--        x_in <= to_signed(100,16);  wait for 10 ns;
--        x_in <= to_signed(0,16);   wait for 10 ns;
--        x_in <= to_signed(0,16); wait for 10 ns;
--        x_in <= to_signed(100,16);   wait for 10 ns;
        x_in <= to_signed(0,16);   wait for 100 ns;

        wait;
    end process;

end Behavioral;
