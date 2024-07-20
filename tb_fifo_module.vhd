----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2024 13:51:44
-- Design Name: 
-- Module Name: fifo_module_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use std.textio.all; -- textio kütüphanesi ekleniyor
use ieee.std_logic_textio.all;

entity tb_fifo_module is
end tb_fifo_module;

architecture behavior of tb_fifo_module is

    -- Component Declaration for the Unit Under Test (UUT)
    component fifo_module
    port(
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
    end component;

    -- Testbench signals
    signal clk            : std_logic := '0';
    signal rst            : std_logic := '0';
    signal write_en       : std_logic := '0';
    signal read_en        : std_logic := '0';
    signal data_send      : std_logic_vector(7 downto 0) := (others => '0');
    signal out_data       : std_logic_vector(7 downto 0);
    signal out_data_valid : std_logic;
    signal out_filled     : std_logic;
    signal out_filling    : std_logic;
    signal out_empty      : std_logic;
    signal out_gonna_empty: std_logic;

    -- Clock generation
    constant clk_period : time := 10 ns;
    -- Clock process definitions
    begin

    -- Instantiate the Unit Under Test (UUT)
    uut: fifo_module
        port map (
            clk => clk,
            rst => rst,
            write_en => write_en,
            read_en => read_en,
            data_send => data_send,
            out_data => out_data,
            out_data_valid => out_data_valid,
            out_filled => out_filled,
            out_filling => out_filling,
            out_empty => out_empty,
            out_gonna_empty => out_gonna_empty
        );
   clk_process:    process begin
       clk <=  '1';
           wait    for clk_period/2;
       clk <=  '0';
           wait    for clk_period/2;
   end process;
    
    rst_process:    process begin
        rst <=  '1';
            wait for    clk_period*2;
        rst <=  '0';
            wait for    clk_period*2;
    end process;
    write_process:  process begin
        write_en    <=  '1';
            wait    for clk_period  *   3;
        write_en    <=  '0';
            wait    for clk_period  *   3;
    end process;
    
    read_process:   process begin
        read_en     <=  '0';
            wait    for clk_period  *   3;
        read_en     <=  '1';
            wait    for clk_period  *   3;
    end process;
    
    --data_send_process:  process begin
    --    data_send   <=  x"63";
    --        wait    for clk_period  *   6;
    --    data_send   <=  x"64";
    --        wait    for clk_period  *   6;
    --    data_send   <=  x"65";
    --        wait    for clk_period  *   6;
    --    
    --end process;   
    
    -- Stimulus process
    file_process: process
        file data_file : text open read_mode is "file_readed.txt"; -- Dosya tanımlaması
        variable line_buffer : line;
        variable int_data : natural;
    begin
    
    
        while not endfile(data_file) loop
            readline(data_file, line_buffer);
            read(line_buffer, int_data);
            data_send <= std_logic_vector(to_unsigned(int_data, 8));
            wait for 20 ns;
        end loop;
        
       
        wait;
    end process;

end behavior;

