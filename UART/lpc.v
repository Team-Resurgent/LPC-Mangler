/*
 * LPC interface module.
 *
 * Hardwired to 0x03fx address range (see inline comments), implementing just
 * the few bits in the status register and the data I/O.
 *
 * Sufficient for the Coreboot console and the SerialICE input.
 *
 * Copyright (C) 2017 Lubomir Rintel <lkundrak@v3.sk>
 * Distributed under the terms of GPLv2 or (at your option) any later version.
 */

module lpc (
	lpc_clk,
	//lpc_rst,
	lpc_data,
	lpc_frame,
	tx_data,
	tx_data_valid,
	//rx_data,
	//rx_data_valid,
	tx_busy
);
	reg rd = 0;
	reg lpc_data_out = 0;
	reg [3:0] out_data = 4'hf;

	input lpc_clk;
	//input lpc_rst;

	inout [3:0] lpc_data;
	input lpc_frame;

	output [7:0] tx_data;
	output tx_data_valid;

	//input [7:0] rx_data;
	//input rx_data_valid;

	input tx_busy;

	wire lpc_clk;
	//wire lpc_rst;
	wire tx_busy;
	assign lpc_data = lpc_data_out ? out_data : 4'bZ;
	wire lpc_frame;

	reg [7:0] tx_data = 0;
	reg tx_data_valid = 0;

	parameter START = 0;
	parameter CTDIR = 1;
	parameter ADDR0 = 2;
	parameter ADDR1 = 3;
	parameter ADDR2 = 4;
	parameter ADDR3 = 5;
	parameter WDATA0 = 6;
	parameter WDATA1 = 7;
	parameter TAR0 = 8;
	parameter SYNC0 = 9;
	parameter SYNC1 = 10;
	parameter RDATA0 = 11;
	parameter RDATA1 = 12;
	parameter TAR1 = 13;
	reg [3:0] state = START;
    
    reg status_port = 0;
    reg data_port = 0;

//	reg [7:0] rxbuf[3:0];
//	reg [1:0] rx_begin = 0;
//	reg [1:0] rx_end = 0;

	always @(posedge lpc_clk)
	begin


//		if (rx_data_valid)
//		begin
//			$display("LPC RX: [%x]", rx_data);
//			rxbuf[rx_end] <= rx_data;
//			rx_end <= rx_end + 1;
//		end

//		$display("RXBUF: begin=%d end=%d [%02x,%02x,%02x,%02x,%02x,%02x,%02x,%02x]", rx_begin, rx_end,
//			rxbuf[0], rxbuf[1], rxbuf[2], rxbuf[3], rxbuf[4], rxbuf[5], rxbuf[6], rxbuf[7]);

		//$display("LPCCLK: [%d] [%x] [%x]", state, lpc_frame, lpc_data);
		if (lpc_frame == 0)
		begin
			if (lpc_data == 0)
				state <= CTDIR;
			else
				state <= START;
		end
		else
		begin
			case (state)
			START:
				tx_data_valid <= 0;
			CTDIR:
				if (lpc_data == 0)
				begin
					rd <= 1;
					state <= ADDR0;
				end
				else if (lpc_data == 2)
				begin
					rd <= 0;
					state <= ADDR0;
				end
				else
					state <= START;
			ADDR0:
				if (lpc_data == 0)
					state <= ADDR1;
				else
					state <= START;
			ADDR1:
				if (lpc_data == 3)
					state <= ADDR2;
				else
					state <= START;
			ADDR2:
				if (lpc_data == 4'hf)
					state <= ADDR3;
				else
					state <= START;
			ADDR3:
                begin
                    data_port <= (lpc_data[3:0] == 4'h8);
                    status_port <= (lpc_data[3:0] == 4'hd);
                    if (rd == 1)
                        state <= TAR0;
                    else
                        state <= WDATA0;
                end
			WDATA0:
                begin
                    state <= WDATA1;
                    if (data_port)
                        tx_data[3:0] <= lpc_data;
                end
			WDATA1:
                begin
                    if (data_port)
                        tx_data[7:4] <= lpc_data;
                    state <= TAR0;
                end
			TAR0:
                begin
                    out_data <= 4'h5;
                    lpc_data_out <= 1;
                    state <= SYNC0;
                end
			SYNC0:
                begin
                    out_data <= 4'h5;
                    state <= SYNC1;
                end
			SYNC1:
                begin
                    out_data <= 4'h0;
                    if (rd)
                        state <= RDATA0;
                    else
                    begin
                        if (data_port)
                            tx_data_valid <= 1;
                        state <= TAR1;
                    end
                end
			RDATA0:
                begin
                    out_data <= 4'hf;
    				if (status_port)
    					out_data <= 0;
                    state <= RDATA1;
                end
			RDATA1:
                begin
                    out_data <= 4'hf;
    				if (status_port)
    					out_data <= (tx_busy ? 4'h0 : 4'h6);
                    state <= TAR1;
                end
			TAR1:
                begin
                    lpc_data_out <= 0;
                    state <= START;
                end
			endcase
		end
	end
endmodule
