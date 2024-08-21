/* This implementation uses a memory array (mem) to store the FIFO elements, as well as read and write pointers (rd_ptr and wr_ptr) to keep track of the next read and write locations in the FIFO.
 The full and empty flags (full_reg and empty_reg) are also used to indicate when the FIFO is full or empty, respectively.

The write logic is triggered on the positive edge of the clock, and writes a new element into the FIFO if the write enable (wr_en) input is asserted and the FIFO is not full.
 The read logic is similarly triggered on the positive edge of the clock, and reads an element from the FIFO if the read enable (rd_en) input is asserted and the FIFO is not empty.
 The empty and full flags are updated accordingly based on the read and write operations.

Note that this implementation assumes an asynchronous reset input (reset) that is active-high. If your design uses an active-low reset, you will need to modify the implementation accordingly.
 Additionally, the implementation assumes a single clock domain, and may need to be modified if you are working with multiple clock domains.
 Finally, this implementation uses simple pointer-based read and write */


module async_fifo #
  (
    parameter WIDTH = 8,     // data width in bits
    parameter DEPTH = 16     // depth in number of elements
  )
  (
    input clk,               // clock input
    input reset,             // asynchronous reset input
    input wr_en,             // write enable input
    input rd_en,             // read enable input
    input [WIDTH-1:0] data_in,  // input data bus
    output [WIDTH-1:0] data_out, // output data bus
    output empty,            // empty flag output
    output full              // full flag output
  );

  // FIFO memory array
  reg [WIDTH-1:0] mem [0:DEPTH-1];

  // FIFO read and write pointers
  reg [$clog2(DEPTH)-1:0] wr_ptr = 0; // ceiling of log 2 of depth size -1 gives the bits needed to represent an array of depth DEPTH 
  reg [$clog2(DEPTH)-1:0] rd_ptr = 0;

  // FIFO full and empty flags
  reg full_reg = 0;
  reg empty_reg = 1;

  // write logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      wr_ptr <= 0;
      full_reg <= 0;
      empty_reg <= 1;
    end else if (wr_en && !full_reg) begin
      mem[wr_ptr] <= data_in;
      wr_ptr <= wr_ptr + 1;
      if (wr_ptr == DEPTH-1)
        wr_ptr <= 0;
      if (wr_ptr == rd_ptr)
        full_reg <= 1;
      empty_reg <= 0;
    end
  end

  // read logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      rd_ptr <= 0;
      full_reg <= 0;
      empty_reg <= 1;
    end else if (rd_en && !empty_reg) begin
      data_out <= mem[rd_ptr];
      rd_ptr <= rd_ptr + 1;
      if (rd_ptr == DEPTH-1)
        rd_ptr <= 0;
      if (rd_ptr == wr_ptr)
        empty_reg <= 1;
      full_reg <= 0;
    end
  end

  // output signals
  assign full = full_reg;
  assign empty = empty_reg;

endmodule
