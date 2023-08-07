/*
 * UART transmitter.
 * Hardwired to 115200 8-N-1 with 33 MHz clock source (see inline comments).
 *
 * Copyright (C) 2017 Lubomir Rintel <lkundrak@v3.sk>
 * Distributed under the terms of GPLv2 or (at your option) any later version.
 */

module uart_tx (
	clk,
	tx_data,
	tx_data_valid,
	tx,
	busy
);
	output uart_tx;
	output tx_busy;


	reg txr = 1'bZ;
    assign uart_tx = txr;

	wire tx_busy;

	// 286 * 115200 = 32947200 Hz
    // 6872 * 4800 = 32985600 Hz
	parameter DIVISOR = 286;
	reg [8:0] divisor = 0;

	parameter IDLE = 0;
	parameter ENABLE = 1;
	parameter START = 2;
	parameter tx_data0 = 3;
	parameter tx_data1 = 4;
	parameter tx_data2 = 5;
	parameter tx_data3 = 6;
	parameter tx_data4 = 7;
	parameter tx_data5 = 8;
	parameter tx_data6 = 9;
	parameter tx_data7 = 10;
	parameter STOP = 11;
	reg [3:0] tx_state = IDLE;
	assign busy = (tx_state > IDLE);

	always @(posedge lpc_clk)
	begin
		// $display("UARTCLK: [%d] [%d] [%d] {%d}", tx_state, tx_data_valid, divisor, tx);
		if (tx_data_valid == 1 && tx_state == IDLE)
			tx_state = ENABLE;

		if (divisor == DIVISOR)
		begin
			divisor <= 0;
			if (tx_state > IDLE && tx_state < STOP)
				tx_state = tx_state + 1;
			else
				tx_state = IDLE;
			case (tx_state)
			IDLE: txr <= 1'bZ;
			START: txr <= 0;
			tx_data0: txr <= tx_data[0];
			tx_data1: txr <= tx_data[1];
			tx_data2: txr <= tx_data[2];
			tx_data3: txr <= tx_data[3];
			tx_data4: txr <= tx_data[4];
			tx_data5: txr <= tx_data[5];
			tx_data6: txr <= tx_data[6];
			tx_data7: txr <= tx_data[7];
			STOP: txr <= 1;
			endcase
		end
		else
			divisor <= divisor + 1;
	end
endmodule
