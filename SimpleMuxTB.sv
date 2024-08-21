module simplemuxtb();

parameter N=8;

logic [N-1:0] a_i;
logic [N-1:0] b_i;
logic sel;
logic [7:0] y_o;

mux MUX (.*);

initial begin 

	for (int i=0; i<(N+2); i++) begin
	a_i = $urandom_range( 0, 8'ff);
	b_i   = $urandom_range (0, 8'hFF);
      sel_i = $random%2;
      #5;
    end
  end

  initial begin
    $dumpfile("day1.vcd");
    $dumpvars(0, day1_tb);
  end

endmodule