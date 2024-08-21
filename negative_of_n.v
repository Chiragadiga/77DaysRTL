// in binary, the negative of a number is represented as its 2's compliment.
/* we want to subtract 12 from 69. Now, 69 - 12 = 69 + (-12). To get the negative of 12 we take its binary representation, invert, and add one.

 0000 0000 0000 0000 0000 0000 0000 1100
 Invert the digits.

 1111 1111 1111 1111 1111 1111 1111 0011
And add one.

 1111 1111 1111 1111 1111 1111 1111 0100 */


parameter   BUS_WIDTH = 4;


module negativeofn;
  input [BUS_WIDTH-1:0] N;
  output reg [BUS_WIDTH-1:0] minus_N;
  reg [BUS_WIDTH-1:0] temp;
 
 always @([BUS_WIDTH-1:0]N or [BUS_WIDTH-1:0]minus_N)
 begin
 
    
    temp	= ~N; // N's compliment
	minus_N = temp + 1; // plus one
	

 /* another line of code would be 
minus_N = 0-N; // in binary 0- Number would be 2's Comp[liment  */


  end
endmodule