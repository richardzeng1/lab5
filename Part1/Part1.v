module Part1 (SW, LEDR, HEX0, HEX1, KEY);
    input [9:0] SW;
	 output [7:0] LEDR;
	 output [6:0] HEX0;
	 output [6:0] HEX1;
	 input [2:0] KEY;
	 
	 // SW 1 enable
	 // SW 0 clear b
	 // KEY 0 as clock
	 //wire w0, w1, w2, w3, w4, w5, w6, w7;
	 wire [7:0] w;
	
	 TFlipFlop f0(
	     .T(SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[0])
	 );
	 
	 TFlipFlop f1(
	     .T(w[0] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[1])
	 );
	 
	 TFlipFlop f2(
	     .T(w[0] & w[1] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[2])
	 );
	 
	 TFlipFlop f3(
        .T(w[0] & w[1] & w[2] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[3])
	 );
	 
	 TFlipFlop f4(
	     .T(w[0] & w[1] & w[2] & w[3] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[4])
	 );
	 
	 TFlipFlop f5(
	     .T(w[0] & w[1] & w[2] & w[3] & w[4] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[5])
	 );
	 
	 TFlipFlop f6(
	     .T(w[0] & w[1] & w[2] & w[3] & w[4] & w[5] & SW1),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[6])
	 );
	 
	 TFlipFlop f7(
	     .T(w[0] & w[2] & w[3] & w[4] & w[5] & w[6] & w[1] & SW[1]),
		  .clock(KEY[0]),
		  .clear_b(SW[0]),
		  .q(w[7])
	 );
	 
	 assign LEDR[7:0] = w[7:0];

	 
	 hex_decoder d1(.hex_digit(w[3:0]), .segments(HEX0));
	 hex_decoder d2(.hex_digit(w[7:4]), .segments(HEX1));
	 
	 
endmodule

module TFlipFlop (T, clock, clear_b, q);
    input T, clock, clear_b; // clear_b does not have not, just doing it using neg edge
	 output reg q;
	 	 
	 always @(posedge clock, negedge clear_b)
	     begin
		      if (~clear_b)
				    q <= 1'b0;
				else
				    q <= T ^ q;
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
