----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Selahattin ABAKAY
-- 
-- Create Date: 10.05.2024 13:38:22
-- Design Name: fifo
-- Module Name: fifo fsm
-- Project Name: fifo fsm
-- Target Devices: Basys3 FPGA Kit
-- Tool Versions: Xilinx Vivado
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
    generic(
        FIFO_DEPTH: integer := 256
    );
    port (
        clk             : in  std_logic;
        rst             : in  std_logic;
        write_en        : in  std_logic;
        read_en         : in  std_logic;
        data_send       : in  std_logic_vector(7 downto 0);
        out_data        : out std_logic_vector(7 downto 0);
        out_data_valid  : out std_logic;
        out_filled      : out std_logic;
        out_filling     : out std_logic;
        out_empty       : out std_logic;
        out_gonna_empty : out std_logic
    );
end fifo;

architecture arch of fifo is

    type fifo_width is array(0 to FIFO_DEPTH - 1) of std_logic_vector(7 downto 0); -- 256x8 bit FIFO Structure
    signal FIFO: fifo_width := (others => (others => '0'));
    signal out_data_sig        : std_logic_vector(7 downto 0);
    signal fifo_address        : unsigned(2 downto 0) := (others => '0');
    signal bit_count           : unsigned(2 downto 0) := (others => '0');
    signal out_data_valid_sig  : std_logic;
    signal out_filled_sig      : std_logic;
    signal out_filling_sig     : std_logic;
    signal out_empty_sig       : std_logic;
    signal out_gonna_empty_sig : std_logic;

    signal empty_flag          : std_logic := '0';
    signal filled_flag         : std_logic := '0';

    signal fifo_count          : integer range 0 to FIFO_DEPTH - 1 := 0;

begin

    out_data <= out_data_sig; 
    out_data_valid <= out_data_valid_sig;
    out_filled <= filled_flag;
    out_filling <= out_filling_sig;
    out_empty <= empty_flag;
    out_gonna_empty <= out_gonna_empty_sig;

    filled_flag <= '1' when fifo_count = FIFO_DEPTH - 1 else '0';

    empty_flag <= '1' when fifo_count = 0 else '0';

    process(clk, rst)
    begin
        if rst = '1' then
            out_data_sig <= (others => '0');
            fifo_count <= 0;
            fifo_address <= (others => '0');
            FIFO <= (others => (others => '0'));
        elsif rising_edge(clk) then
       
        bit_count   <=  bit_count   +   1;
            if write_en = '1' and read_en = '0' then
                fifo_count <= fifo_count + 1;
                fifo_address <= fifo_address + 1;
                if empty_flag = '1' and filled_flag = '0' then
                    FIFO(to_integer(fifo_address)) <= data_send;
                    out_data_sig(to_integer(bit_count)) <=   data_send(to_integer(bit_count));
                end if;
            elsif write_en = '0' and read_en = '1' then
                fifo_address <= fifo_address + 1;
                fifo_count <= fifo_count - 1;
                if empty_flag = '0' and filled_flag = '1' then
                    out_data_sig <= FIFO(to_integer(fifo_address));
                    elsif(write_en = '1'    and write_en = '0') then
                       fifo_count   <=  fifo_count  -   1;          
                    end if;
                end if;
        end if;
    end process;

    out_data_valid_sig <= '1' when (write_en = '1' and read_en = '0') else '0';
    out_filling_sig <= '1' when (fifo_count > 0 and fifo_count < FIFO_DEPTH - 1) else '0';
    out_gonna_empty_sig <= '1' when (fifo_count = 1) else '0';

end architecture;
