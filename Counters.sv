// let's start with a simple counter 0 to 10

module SimpleCounter
(
input wire clk,
input wire rst,
output reg [7:0]count
);
wire [7:0] m_o;
wire e_o;

always_ff @(posedge clk or posedge rst)
	if(rst)
	count<= 8'b0;
	else 
	count<= next_count;
	
assign next_count<= m_o + 'b1;
assign m_o<= (count==10)? 'b1:count; 

endmodule


// count odd numbers till 100 

/* module simplecounter(
input wire clk,
output reg [7:0] count;
);

always_ff @(posedge clk or posedge rst)
	if(rst)
	count<='b1;
	else 
	count <=next_count;
	
assign next_count<=count?+'b2;
 endmodule

 */










// count 


assign 
