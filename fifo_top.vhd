----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Selahattin ABAKAY
-- 
-- Create Date: 10.05.2024 15:12:14
-- Design Name: fifo_module
-- Module Name: FIFO TOP MODULE
-- Project Name: FIFO
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

entity fifo_module is
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
end fifo_module;

architecture arch of fifo_module is
    component fifo
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

begin
    fifo_map: fifo
    port map(
        clk             => clk,
        rst             => rst,
        write_en        => write_en,
        read_en         => read_en,
        data_send       => data_send,
        out_data        => out_data,
        out_data_valid  => out_data_valid,
        out_filled      => out_filled,
        out_filling     => out_filling,
        out_empty       => out_empty,
        out_gonna_empty => out_gonna_empty
    );
end arch;

