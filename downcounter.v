module count_downtimer(clk, in, latch, dec, zero, value, dvd2);
input clk;
input [7:0] in;
input latch, dec, dvd2;
output zero;
output [7:0] value;
reg [7:0] value;
wire zero;
always@(posedge clk)
begin
if (latch)
value<= in;
else if (dec && !zero)
value <= value - 1'b1;
else if (dvd2 && !latch && !dec)
value <= value >> 1;
end
assign zero = ~|value;
endmodule