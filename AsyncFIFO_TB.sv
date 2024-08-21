module tb_async_fifo;

  // Define parameters for the FIFO
  parameter DEPTH = 16;
  parameter WIDTH = 8;

  // Declare signals
  logic clk, rst;
  logic [WIDTH-1:0] data_in, data_out;
  logic wr_en, rd_en, full, empty;

  // Instantiate the FIFO
  async_fifo #(.DEPTH(DEPTH), .WIDTH(WIDTH)) fifo (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .full(full),
    .empty(empty)
  );

  // Drive the clock signal
  always #5 clk = ~clk;

  // Drive the reset signal
  initial begin
    rst = 1;
    #10;
    rst = 0;
  end

  // Generate random data and control signals
  initial begin
    repeat (20) begin
      // Write data into the FIFO
      if (!full) begin
        data_in = $random % 256;
        wr_en = 1;
      end
      else begin
        wr_en = 0;
      end

      // Read data from the FIFO
      if (!empty) begin
        rd_en = 1;
      end
      else begin
        rd_en = 0;
      end

      #10;
    end

    $finish;
  end

endmodule
