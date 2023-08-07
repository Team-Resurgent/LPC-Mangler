/*
 * A simple LPC UART device.
 * Glues a transmitter part, a receiver part and a LPC bus interface.
 *
 * Copyright (C) 2017 Lubomir Rintel <lkundrak@v3.sk>
 * Distributed under the terms of GPLv2 or (at your option) any later version.
 */

module device (
	lpc_clk,
	lpc_data,
	lpc_frame,
    uart_tx
);
	reg rd = 0;
	reg lpc_data_out = 0;
	reg [3:0] out_data = 4'hf;

	input lpc_clk;

	inout [3:0] lpc_data;
	input lpc_frame;

	assign lpc_data = lpc_data_out ? out_data : 4'bZ;

	reg [7:0] tx_data = 0;
	reg tx_data_valid = 0;

	parameter LPC_START = 0;
	parameter LPC_CTDIR = 1;
	parameter LPC_ADDR0 = 2;
	parameter LPC_ADDR1 = 3;
	parameter LPC_ADDR2 = 4;
	parameter LPC_ADDR3 = 5;
	parameter LPC_WDATA0 = 6;
	parameter LPC_WDATA1 = 7;
	parameter LPC_TAR0 = 8;
	parameter LPC_SYNC0 = 9;
	parameter LPC_SYNC1 = 10;
	parameter LPC_RDATA0 = 11;
	parameter LPC_RDATA1 = 12;
	parameter LPC_TAR1 = 13;
	reg [3:0] lpc_state = LPC_START;
    
    reg status_port = 0;
    reg data_port = 0;

	reg txr = 1;

    output uart_tx;
    assign uart_tx = txr;

	wire tx_busy;

	// 286 * 115200 = 32947200 Hz
    // 6872 * 4800 = 32985600 Hz
	parameter DIVISOR = 1736;
	reg [10:0] divisor = 0;

	parameter TX_IDLE = 0;
	parameter TX_ENABLE = 1;
	parameter TX_START = 2;
	parameter TX_DATA0 = 3;
	parameter TX_DATA1 = 4;
	parameter TX_DATA2 = 5;
	parameter TX_DATA3 = 6;
	parameter TX_DATA4 = 7;
	parameter TX_DATA5 = 8;
	parameter TX_DATA6 = 9;
	parameter TX_DATA7 = 10;
	parameter TX_STOP = 11;
	reg [3:0] tx_state = TX_IDLE;
	assign tx_busy = (tx_state > TX_IDLE);


	always @(posedge lpc_clk)
	begin
        // UART TX
		if (tx_data_valid == 1 && tx_state == TX_IDLE)
			tx_state = TX_ENABLE;

		if (divisor == DIVISOR)
		begin
			divisor <= 0;
			if (tx_state > TX_IDLE && tx_state < TX_STOP)
				tx_state = tx_state + 1;
			else
				tx_state = TX_IDLE;
			case (tx_state)
			TX_IDLE: txr <= 1;
			TX_START: txr <= 0;
			TX_DATA0: txr <= tx_data[0];
			TX_DATA1: txr <= tx_data[1];
			TX_DATA2: txr <= tx_data[2];
			TX_DATA3: txr <= tx_data[3];
			TX_DATA4: txr <= tx_data[4];
			TX_DATA5: txr <= tx_data[5];
			TX_DATA6: txr <= tx_data[6];
			TX_DATA7: txr <= tx_data[7];
			TX_STOP: txr <= 1;
			endcase
		end
		else
			divisor <= divisor + 1;

        // LPC STATE MACHINE
		if (lpc_frame == 0)
		begin
			if (lpc_data == 0)
				lpc_state <= LPC_CTDIR;
			else
				lpc_state <= LPC_START;
		end
		else
		begin
			case (lpc_state)
			LPC_START:
				tx_data_valid <= 0;
			LPC_CTDIR:
				if (lpc_data == 0)
				begin
					rd <= 1;
					lpc_state <= LPC_ADDR0;
				end
				else if (lpc_data == 2)
				begin
					rd <= 0;
					lpc_state <= LPC_ADDR0;
				end
				else
					lpc_state <= LPC_START;
			LPC_ADDR0:
				if (lpc_data == 0)
					lpc_state <= LPC_ADDR1;
				else
					lpc_state <= LPC_START;
			LPC_ADDR1:
				if (lpc_data == 3)
					lpc_state <= LPC_ADDR2;
				else
					lpc_state <= LPC_START;
			LPC_ADDR2:
				if (lpc_data == 4'hf)
					lpc_state <= LPC_ADDR3;
				else
					lpc_state <= LPC_START;
			LPC_ADDR3:
                begin
                    data_port <= (lpc_data[3:0] == 4'h8);
                    status_port <= (lpc_data[3:0] == 4'hd);
                    if (rd == 1)
                        lpc_state <= LPC_TAR0;
                    else
                        lpc_state <= LPC_WDATA0;
                end
			LPC_WDATA0:
                begin
                    lpc_state <= LPC_WDATA1;
                    if (data_port)
                        tx_data[3:0] <= lpc_data;
                end
			LPC_WDATA1:
                begin
                    if (data_port)
                        tx_data[7:4] <= lpc_data;
                    lpc_state <= LPC_TAR0;
                end
			LPC_TAR0:
                begin
                    out_data <= 4'h5;
                    lpc_data_out <= 1;
                    lpc_state <= LPC_SYNC0;
                end
			LPC_SYNC0:
                begin
                    out_data <= 4'h5;
                    lpc_state <= LPC_SYNC1;
                end
			LPC_SYNC1:
                begin
                    out_data <= 4'h0;
                    if (rd)
                        lpc_state <= LPC_RDATA0;
                    else
                    begin
                        if (data_port)
                            tx_data_valid <= 1;
                        lpc_state <= LPC_TAR1;
                    end
                end
			LPC_RDATA0:
                begin
                    out_data <= 4'hf;
    				if (status_port)
    					out_data <= 0;
                    lpc_state <= LPC_RDATA1;
                end
			LPC_RDATA1:
                begin
                    out_data <= 4'hf;
    				if (status_port)
    					out_data <= (tx_busy ? 4'h0 : 4'h6);
                    lpc_state <= LPC_TAR1;
                end
			LPC_TAR1:
                begin
                    lpc_data_out <= 0;
                    lpc_state <= LPC_START;
                end
			endcase
		end
	end
endmodule
