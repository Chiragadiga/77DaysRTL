module edgedetectortb();

	logic a_i;
	logic clk;
	logic rst;
	logic rising_o;
	logic falling_o;

edgedetector ed(.*);

	always begin
		clk=1'b1;
		#5;
		clk=1'b0;
		#5;
		end
	
	initial begin
	rst=1'b1;
	a_i<=1'b1;
	@(posedge clk);
	rst=1'b0;
	@(posedge clk);
	for(int i=0; i<=32; i++) begin
		a_i <= $random%2;
		@(posedge clk);
		end
	$finish();
	end

//dump VCD
initial begin 
$dumpfile("day3.vcd");
$dumpvars(0,day3_tb);
end
endmodule
