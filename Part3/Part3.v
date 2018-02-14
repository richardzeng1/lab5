module Part3(SW, LEDR, KEY, CLOCK_50);

    input [2:0] SW;
	 output [1:0] LEDR;
	 input [1:0] KEY;
	 input CLOCK_50;
	 
	 wire to_reg;
	 wire reg_enable;
	 wire to_counter;
	 wire bit;
	 
	 mux m(
	     .SW(SW),
		  .out(to_reg)
	 );
	 
	 countDown2 cd(
	     .out(to_counter),
		  .clock(CLOCK_50)
	 );
	 
	 count c(
	     .out(reg_enable),
		  .enable(to_counter),
		  .clock(CLOCK_50)
	 );
	 
	 register r(
	     .val(to_reg),
		  .load(KEY[1]),
		  .reset_n(KEY[0]),
		  .enable(reg_enable),
		  .clock(CLOCK_50),
		  .led_val(bit)
	 );
	 
	 assign LEDR[0] = bit;

endmodule

module register (val, load, reset_n, enable, clock, led_val);
    input [13:0] val;
	 input load;
	 input reset_n;
	 input enable;
	 output reg led_val;
	 input clock;
	 
	 reg [13:0] out;
	 
	 always @(*)
	 begin 
	     if (1)
		      led_val = out[0];
				
	 end
	 
	 
	 always @(posedge clock, negedge reset_n)
	 begin
	     
	     if (reset_n == 1'b0)
		      out <= 14'b00000000000000;
		  else if (load==1'b0)
		      out <= val;
		  else
		  begin
		      if (enable==1'b1)

					 out <= out >> 1;
					
		  end 
	 end 

endmodule


module countDown2(out, clock);
    // count down
	 reg [28:0] total = 28'b0101111101011110000011111111;
	 output reg out = 1'b1;
	 input clock;
	 
	 always @(posedge clock)
	 begin

	     if (total > 1'b1)
			   total <= total-1'b1;
				
		  else
				total <= 28'b0101111101011110000011111111;
		  
	 end
	 
	 always @(*)
	 begin

	     if (total > 1'b1)
			   out = 1'b1;
				
		  else
				out = 1'b0;
		  
	 end
	 
	 
endmodule

module count(out, enable, clock);
    // module counts up

	 input enable;

	 input clock;
	 output reg [7:0] out = 1'b0;
	 
	 always @(posedge clock)
	 begin
	     if (enable == 1'b0)
		      out <= out+8'b00000001;
	 end 
	 
	 
endmodule

module mux(SW, out);
    input [2:0] SW;
	 output reg [13:0] out;
	 
	 always @(*)
	 begin
	     if (SW == 3'b000)
		      out = 13'b00000000010101;
		  else if (SW == 3'b001)
		      out = 13'b00000000000111;
		  else if (SW == 3'b010)
		      out = 13'b00000001110101;
		  else if (SW == 3'b011)
		      out = 13'b00000111010101;
		  else if (SW == 3'b100)
		      out = 13'b00000111011101;
		  else if (SW == 3'b101)
		      out = 13'b00011101010111;
		  else if (SW == 3'b110)
		      out = 13'b01110111010111;
		  else 
		      out = 13'b00010101110111;
	 end
endmodule
