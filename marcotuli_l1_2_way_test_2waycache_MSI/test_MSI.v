`timescale 1ns / 100ps
module test_MSI();

  reg clk;
  reg reset_n;
  reg ready_mem;
 initial begin
	clk = 1'd0;
	reset_n = 1;
	ready_mem = 1;
	//#5 reset_n = 1;	ready_mem = 1;
	forever
	#10 clk = ~clk;
	#100 $finish;
	end

   msi_main callMain (clk, reset_n, ready_mem);

 endmodule

