module top();

	logic clk=0;
	logic rst=1;

	// Calling the interface
	AccInterface acc_inst(clk);
	accumulator dut(.sum(acc_inst.sum), .data_in(acc_inst.data_in), .rst(acc_inst.rst), .clk(acc_inst.clk));

	initial begin
	//Generate clock
	forever #10 clk=~clk;  //make a clock
	end
 
	// Check reset success or fail
	initial begin
    	// Apply reset at the beginning
    	@(posedge acc_inst.clk);
    	rst <= 0;
    	@(posedge acc_inst.clk);
    	rst <= 1;
    	@(posedge acc_inst.clk);
    	if (dut.sum != 16'h0000) 
    		$display("@%10t Reset failed.",$time);
  	end

	//dynamic array for data_in of 500 bytes 
	logic [7:0] data_in_array[] =new [500];

	//Queue for sum values 
	logic [15:0] sum_queue[$];

	//Array for expected sum
	logic [15:0] expected_sums=0;
	
	logic [15:0] expected_sum_array[] =new [500];

	initial begin
		//Radomise data_in and populate data_in of DUT
		for (int i=0; i<500; i++) begin
			data_in_array[i] = $random;
		end

		for(int i=0; i<500; i++) begin
			rst <= 0;
			acc_inst.data_in <= data_in_array[i]; //Populating data_in from the generated values
			@(posedge acc_inst.clk);
			sum_queue.push_back(dut.sum); // Pushing the output values to queue
		end

		/* for (int i=0;i<500;i++) begin
			expected_sum_array[i] += data_in_array[i];
		if(expected_sum_array[i] > 16'hFFFF)
				expected_sum_array[i] = 16'hFFFF;
		end */


		if(dut.sum>16'hFFFF) 
			dut.sum = 16'hFFFF; // Saturate the ouput

/* 
		for (int i=0;i<500;i++) begin
    	  @(posedge acc_inst.clk);
      	if (expected_sum_array[i] !== acc_inst.sum) 
      	$display("Output mismatch.");
    	end  */

    	// Print input and output arrays
    	$display("Input data:");
    	foreach (data_in_array[i])
    	$display("%h",data_in_array[i]);
    
    	$display("Accumulated sum:");
    	sum_queue.push_back(dut.sum);
    	foreach (sum_queue[i]) 
    	$display("%h", sum_queue[i]);
 	end

	initial begin
	$vcdpluson; 
	$vcdplusmemon;
	$dumpfile("dump.vcd");
	$dumpvars;
	end

endmodule  