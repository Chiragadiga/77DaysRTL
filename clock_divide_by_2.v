// input clock is divided by 2.
// 100MHz clock domain is converted to a 50MHz Clock domain.
// the verilog method would simply be a ">>" operation on the input n. 
// reset is 0high. 
// The Rst is Asynchronous to the clock by being in the always statement.
/* `timescale 1ns/1ps;  // set time_unit to 1ns. i.e 10 would be 10ns. and a fraction value will be recognized to the precision of a 100th percentile. 10.9 would be 10 nano and 9pico

parameter   BUS_WIDTH = 32; */


module frequency_divider_by2 ( clk ,rst,out_clk );

output reg  out_clk;
input  clk ;
input rst;
always @(posedge clk or negedge rst)
begin
if (~rst)
     out_clk <= 1'b0;
else
     out_clk <= ~out_clk;	
end
endmodule