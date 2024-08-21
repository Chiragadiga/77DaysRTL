/* /* // Declaration of interface
interface acc_if(input logic clk, rst, input logic [7:0] data_in, output logic [15:0] sum);
//logic clk;
//logic rst;					//Reset and clock inputs/
//logic [7:0] data_in;				// input data
//logic [15:0] sum;				// Accumulated output


// Modport declaration for signal direction definition
modport sys(input rst,data_in, output sum);

//Clocking block
clocking cb @(posedge clk);
//default input #5ns output #10ns;
 	/* output rst;
    output data_in; 
    input  sum;  */
/* endclocking

modport test(clocking cb);


endinterface */ 
interface AccInterface(input logic clk);
	logic [7:0] data_in;
	logic [15:0] sum;
	logic rst;
  clocking test_clkg @(posedge clk);
  endclocking
  
  modport tb_port(input clk, rst, output data_in, input sum);
  modport dut_port(input clk, rst, input data_in, output sum);
endinterface