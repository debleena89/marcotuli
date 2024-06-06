module ProcessorCoreA(
	input clk, input [7:0] fetched_data,
	output read, write, output [15:0] address, output [7:0] write_data
);//cada um com suas instrucoes separadas
// Instructions Scheme:
// |op ~1bit|address ~9bits|data ~16bits| ~26bits
//  25       24          16 15         0
// where, op==1: write, op==0 read 
	integer i,index;
	reg [24:0] instructions [0:64];//64x21bits instructions memory size
	task delay;
	begin
	@(negedge clk);
	end
	endtask	
	initial begin
		$readmemb("/home/debleena/Thales/marcotuli_l1_2_way_test_2waycache_MSI/core1_0_instructions.txt", instructions); // memory file
		index <= -1;
		$display("core0_instructions: ");
		for(i=0; i<7; i=i+1) begin
			$display("the instructions are: %b",instructions[i]);
		end
	end
	
	always@(posedge clk)begin
	    delay;
	    delay;
		index <= index + 1;
		//delay;
		
		
		//$display(".............................index = %d..............................",index);
	end
	
	assign write = instructions[index][24];
	assign address = instructions[index][24:8];
	assign write_data = write?instructions[index][7:0]:8'dz;
	assign read = instructions[index][24] == 0 ? 1'b1:1'b0;
	
	
endmodule
