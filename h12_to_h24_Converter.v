module h12_h24_converter (h12, ap, h24);
input [3:0] h12;
input ap;
output [4:0] h24;

'ifdef BUGGY
wire[4:0] b1,b2,b3,h24;
wire s1,s2;
assign s1 = h12==12;
assign b1 = s1? 0: 12;
assign b2 = h12 +b1;
assign b3 = s1 ? 0 : h12;
assign h24 = ap?b3:h12;
'endif

wire [4:0] b1,b2,b3,b4,h24;
wire s1,s2;
assign b1 = ap? 12:0;
assign s1 = h12==12;
assign b2 = h12+12;
assign b3 = ap? b2: h12;
assign h24 = s1?b1:b3;
endmodule
