library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fir_filter is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        x_in    : in  signed(15 downto 0); -- 16-bit input
        y_out   : out signed(31 downto 0)  -- 32-bit output
    );
end fir_filter;

architecture Behavioral of fir_filter is

    constant N : integer := 25; -- number of taps

    -- Filter coefficients (16-bit signed)
    type coeff_array is array (0 to N-1) of signed(15 downto 0);
    constant b : coeff_array := (
        to_signed(621,16), 
        to_signed(1252,16), 
        to_signed(955,16), 
        to_signed(-464,16),
        to_signed(-1427,16), 
        to_signed(-442,16), 
        to_signed(1279,16), 
        to_signed(815,16),
        to_signed(-2028,16), 
        to_signed(-2978,16), 
        to_signed(1849,16), 
        to_signed(9985,16),
        to_signed(14052,16), 
        to_signed(9985,16), 
        to_signed(1849,16), 
        to_signed(-2978,16),
        to_signed(-2028,16), 
        to_signed(815,16), 
        to_signed(1279,16), 
        to_signed(-442,16),
        to_signed(-1427,16), 
        to_signed(-464,16), 
        to_signed(955,16), 
        to_signed(1252,16),
        to_signed(621,16)
    );



    -- Shift register for input samples
    type sample_array is array (0 to N-1) of signed(15 downto 0);
    signal x_reg : sample_array := (others => (others => '0'));

    signal acc : signed(63 downto 0);

begin

    process(clk)
        variable sum : signed(63 downto 0);
    begin
        if rising_edge(clk) then
            if reset = '1' then
                x_reg <= (others => (others => '0'));
                y_out <= (others => '0');
            else
                -- shift register
                for i in N-1 downto 1 loop
                    x_reg(i) <= x_reg(i-1);
                end loop;
                x_reg(0) <= x_in;

                -- multiply-accumulate
                sum := (others => '0');
                for i in 0 to N-1 loop
                    sum := sum + resize(x_reg(i), 32) * resize(b(i), 32);
                end loop;

                acc <= sum;
                 y_out <= resize(acc,32);
            end if;
        end if;
    end process;

end Behavioral;
