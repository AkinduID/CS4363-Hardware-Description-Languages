library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MovingAverage is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        signal_in   : in  STD_LOGIC_VECTOR(5 downto 0); -- 6 seats
        average_out : out STD_LOGIC
    );
end MovingAverage;

architecture Behavioral of MovingAverage is

    type HistoryArray is array (2 downto 0) of STD_LOGIC_VECTOR(5 downto 0); -- last 3 cycles
    signal history : HistoryArray := (others => (others => '0'));
    signal sum     : INTEGER := 0;

begin
    process (clk, reset)
    variable temp_sum : INTEGER;
    begin
        if reset = '1' then
            history <= (others => (others => '0'));
            sum     <= 0;
            average_out <= '0';

        elsif rising_edge(clk) then
            -- Shift history
            history(2) <= history(1);
            history(1) <= history(0);
            history(0) <= signal_in;

            -- Calculate sum of all ones in the window
            temp_sum := 0;
            for i in 0 to 2 loop -- time window
                for j in 0 to 5 loop -- 6 seats
                    if history(i)(j) = '1' then
                        temp_sum := temp_sum + 1;
                    end if;
                end loop;
            end loop;

            sum <= temp_sum;

            -- Threshold: average ? 2 ? total sum ? 6 over 3 cycles
            if sum >= 6 then
                average_out <= '1';
            else
                average_out <= '0';
            end if;
        end if;
    end process;

end Behavioral;
