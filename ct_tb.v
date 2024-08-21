module counter_testbench();
reg [7:0] in;
reg latch, dec, dvd2;
reg CLK;
wire [7:0] value;
wire zero;
always # 10 CLK = ~CLK;
count_downtimer dut (.latch(latch), .dec(dec), .dvd2(dvd2), .clk(CLK), .in(in), .value(value), .zero(zero));
initial begin
$vcdpluson; //when using makefile use this immediately after initial begin statement
$monitor ("time = %5d ns, latch = %1b, Clock = %1b, divide=%1b, dec = %1b, in = %3d, value = %3d, zero = %1b", $time, latch, CLK, dvd2, dec, in, value, zero);
$dumpfile("downcounter.vcd");
$dumpvars;
CLK = 0;
latch=0;
dec=0;
dvd2=0;
in = 8'b00010001;
#25 latch = 1;
#10 latch = 0;
#10 dec = 1;
#10 dec = 0;
#10 dvd2 = 1;
#100 $finish;
end
endmodule