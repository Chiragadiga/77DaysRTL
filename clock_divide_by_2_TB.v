`timescale 1ns/100ps   // set time_unit to 1ns. i.e 10 would be 10ns. and a fraction value will be recognized to the precision of a 100th percentile. 10.9 would be 10 nano and 9pico

module frequencydiv;
output reg clk;
output reg rst;
input wire out_clk;
frequency_divider_by2 freq1(clk,rst,out_clk);
initial
clk = 1'b0;
always
#10 clk = ~clk;
initial
begin
$monitor($time,"clk = %b,rst = %b,out_clk = %b",clk,rst,out_clk);
rst =0;
#20 rst =1;
#100 $finish;
end
initial
begin
     $dumpfile ("frequencydiv.vcd");
     $dumpvars (0,frequencydiv);
end
endmodule