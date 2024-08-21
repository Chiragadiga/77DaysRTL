module fifo_tb;

  // Parameters
  parameter WIDTH = 8;
  parameter DEPTH = 16;
  
  // Testbench signals
  logic clk;
  logic rst;
  logic wr;
  logic rd;
  logic [WIDTH-1:0] data_in;
  logic [WIDTH-1:0] data_out;
  logic full;
  logic empty;
  
  // Instantiate DUT
  fifo dut (
    .clk(clk),
    .rst(rst),
    .wr(wr),
    .rd(rd),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );
  
  // Clock generation
  always #5 clk = ~clk;
  
  // Initialize signals
  initial begin
    clk = 0;
    rst = 1;
    wr = 0;
    rd = 0;
    data_in = 0;
    #10 rst = 0;
  end
  
  // Write and read operations
  initial begin
    // Write data to the FIFO
    wr = 1;
    for (int i = 0; i < DEPTH; i++) begin
      data_in = $random % 256; // $random is an SV function that returns a 32 bit value. this expression applied modulo operator results in a value between 0 and 255 (included)
      #5;
    end
    wr = 0;
    
    // Read data from the FIFO
    rd = 1;
    for (int i = 0; i < DEPTH; i++) begin
      #5;
      if (!empty) begin
        $display("Data out: %d", data_out);
      end
    end
    rd = 0;
  end
  
endmodule

/* This testbench instantiates the FIFO module and generates a clock signal with a period of 10 time units (#5 clk = ~clk;). It also initializes the testbench signals, waits for a reset period, and then performs a write operation to fill the FIFO with random data ($random % 256) and a read operation to read out all the data in the FIFO.

The for loops in the write and read operations iterate for DEPTH iterations, which is the depth of the FIFO defined in the parameters. In the read operation, the $display statement is only executed if the FIFO is not empty to avoid printing uninitialized data. */


