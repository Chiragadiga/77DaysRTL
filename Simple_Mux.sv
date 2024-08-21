// A simple N bit Mux

module mux #
(
parameter N=8;
)
(
input wire [N-1:0] a_i;
input wire [N-1:0] b_i;
input wire s_i;
output wire [N-1:0] y_o;
);

assign y_o = s_i?b_i:a_i;

endmodule
