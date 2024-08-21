module edgedetector(

input wire clk,
input wire rst,
input wire a_i;
output wire rising_o;
output wire falling_o;
);

logic a_ff;

always_ff @(posedge clk or posedge rst)
	if(rst)
	a_ff <= 1'b0;
	else 
	a_ff<=a_i;

assign rising_o <= ~a_ff && a_i;
assign falling_o <= a_ff&& ~a_i;

endmodule 
 

