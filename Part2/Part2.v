module Part2(SW, HEX0, LEDR, CLOCK_50);
    input CLOCK_50;
    output [6:0] HEX0;
	 input [1:0] SW;
	 output [7:0] LEDR;
	 wire to_countDown;
	 reg rate_dividor;
	 wire enable;
	 wire count_val;
    wire [3:0] w;	
	
	 mux m(
	     .w(w),
	     .SW(SW), 
		  .Q(enable)
	);
	
	countDown0 cd0(
		 .total(w[0]),
		 .clock(CLOCK_50)
	);
	
	countDown1 cd1(
		 .out(w[1]),
		 .clock(CLOCK_50)
	);
	
	countDown2 cd2(
		 .out(w[2]),
		 .clock(CLOCK_50)
	);
	
	countDown3 cd3(
		 .out(w[3]),
		 .clock(CLOCK_50)
	);
	
	
	count p(
	    .out(count_val),
		 .enable(enable),
		 .clock(CLOCK_50),
		 .HEX0(HEX0),
		 .LEDR(LEDR)
	);
	
	
	 
endmodule

module countDown0( total, clock);
    // count down
	 output reg [28:0] total = 1'b0;
	 input clock;
	
	 always @(*)
	 begin
	     if (clock == 1'b1)
		      total = 1'b1;
			else
			   total =1'b0;
    end
	
endmodule

module countDown1(out, clock);
    // count down
	 reg [28:0] total = 28'b0010111110101111000001111111; 
	 output reg out = 1'b1;
	 input clock;
	 
	 always @(posedge clock)
	 begin

	     if (total > 1'b1)
			   total <= total-1'b1;
				
		  else
				total <= 28'b0010111110101111000001111111; 
		  
	 end
	 
	 always @(*)
	 begin

	     if (total > 1'b1)
			   out = 1'b1;
				
		  else
				out = 1'b0;
		  
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

module countDown3(out, clock);
    // count down
	 reg [28:0] total = 28'b1011111010111100000111111111; 
	 output reg out = 1'b1;
	 input clock;
	 
	 always @(posedge clock)
	 begin

	     if (total > 1'b1)
			   total <= total-1'b1;
				
		  else
				total <= 28'b1011111010111100000111111111; 
		  
	 end
	 
	 always @(*)
	 begin

	     if (total > 1'b1)
			   out = 1'b1;
				
		  else
				out = 1'b0;
		  
	 end
	 
	 
endmodule

module count(out, enable, clock, HEX0, LEDR);
    // module counts up
	 output [6:0] HEX0;
	 input enable;
	 output [7:0] LEDR;
	 input clock;
	 output reg [7:0] out = 1'b0;
	 
	 always @(posedge clock)
	 begin
	     if (enable == 1'b0)
		      out <= out+8'b00000001;
	 end 
	 
	 assign LEDR = out;
	 hex_decoder ok(.hex_digit(out), .segments(HEX0));
	 
endmodule

module mux(w, SW, Q);
    input [3:0] w;
	 input [1:0] SW;
	 output reg Q;
	 
    always @(*)
	 begin
	 if (SW == 2'b00)
	     Q = w[0];
	 else if (SW == 2'b01)
	     Q = w[1];
	 else if (SW ==2'b10)
	     Q = w[2];
	 else
	     Q = w[3];
    end
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;

    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule


