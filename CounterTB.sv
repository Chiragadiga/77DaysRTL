module simplecountertb();

logic clk;
logic rst;
logic [7:0] count_o;
SimpleCounter sim (.*);

always begin 
clk=1'b0;
#5;
clk=1'b1;
#5;
end 

initial begin 
 rst=1;
 @posedge clk;
 rst=0;
 repeat(20) @posedge clk;
 $display("the current value of counter = %8h", sim.count_o);
 
 end
 endmodule
