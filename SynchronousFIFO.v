/* This code defines a synchronous FIFO module with parameters for data width (WIDTH) and depth (DEPTH). It has clock (clk) and reset (rst) inputs, as well as inputs for write (wr) and read (rd) operations and a data input (data_in) and output (data_out). 
There are also outputs for full (full) and empty (empty) status.

The module uses a memory array (mem) to store the FIFO data and two pointers (rd_ptr and wr_ptr) to keep track of the read and write locations. A counter (cnt) is used to keep track of the number of entries in the FIFO.

The always block is triggered on the positive edge of the clock (posedge clk) and handles the read and write operations. 
If the reset signal (rst) is high, the pointers and counter are reset to their initial values. 
Otherwise, if a write operation is requested and the FIFO is not full, the input data is written to the current write location, the write pointer is incremented, and the counter is incremented. 
If a read operation is requested and the FIFO is not empty, the output data is set to the current read location, the read pointer is incremented, and the counter is decremented. */

module fifo(input clk, rst, wr, rd, data_in, output reg data_out, full, empty);

  parameter WIDTH = 8;
  parameter DEPTH = 16;

  reg [WIDTH-1:0] mem [0:DEPTH-1]; // using a memory array mem to store FIFO elements
  reg [WIDTH-1:0] rd_ptr = 0, wr_ptr = 0;
  reg [WIDTH-1:0] cnt = 0;
  
  assign full = (cnt == DEPTH); // a synchronous fifo is full when wr_ptr is one position below rd_ptr. cnt is incremented at write and decremented at read. ( wr_ptr-rd_ptr=cnt) 
  assign empty = (cnt == 0); // 
  
  always @(posedge clk) begin
    if (rst) begin
      rd_ptr <= 0;
      wr_ptr <= 0;
      cnt <= 0;
    end else begin
      if (wr && !full) begin
        mem[wr_ptr] <= data_in;
        wr_ptr <= (wr_ptr == DEPTH-1) ? 0 : wr_ptr + 1; // wr_ptr is incremented as long as its lesser than the depth 
        cnt <= cnt + 1; // cnt is incrememnted whenever write is performed 
      end
      if (rd && !empty) begin
        data_out <= mem[rd_ptr];
        rd_ptr <= (rd_ptr == DEPTH-1) ? 0 : rd_ptr + 1; // rd_ptr is incrememnted as long as its lesser than depth
        cnt <= cnt - 1; // cnt is decrememnted each time a read is performed 
      end
    end
  end

endmodule
