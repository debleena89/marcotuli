`timescale 1ns / 100ps

module cache_2wsa_tb;

	// Inputs
	reg clock;
	reg reset_n;
	reg [15:0] addr_cpu;
	reg rd_cpu; 
	reg wr_cpu;
	reg ready_mem;

	// Outputs
	wire [15:0] addr_mem;
	wire rd_mem;
	wire wr_mem;
	wire stall_cpu;

	// Bidirs
	wire [7:0] data_cpu;
	wire [7:0] data_mem;
	
	reg [7:0] dcpu;
	reg [7:0] wcpu;
	reg [7:0] dmem;
	reg [7:0] wmem;
	
	// Instantiate the Unit Under Test (UUT)
	
	assign data_cpu = wr_cpu? wcpu : 8'dZ;
	assign data_mem = !wr_mem? dmem : 8'dZ;
        
	//Clock generator block
	initial begin
	clock = 1'd0;
	forever
	#10 clock = ~clock;
	end
	
	task delay;
	begin
	@(negedge clock);
	end
	endtask		
		
	cache_2wsa uut (
		.clock(clock), 
		.reset_n(reset_n), 
		.data_cpu(data_cpu), 
		.data_mem(data_mem), 
		.addr_cpu(addr_cpu), 
		.addr_mem(addr_mem), 
		.rd_cpu(rd_cpu), 
		.wr_cpu(wr_cpu), 
		.rd_mem(rd_mem), 
		.wr_mem(wr_mem), 
		.stall_cpu(stall_cpu), 
		.ready_mem(ready_mem)
	);
	initial begin
		// Initialize Inputs
		reset_n = 0;
		addr_cpu = 0;
		rd_cpu = 0;
		wr_cpu = 0;
		ready_mem = 1;
		wcpu = 0;
		
		repeat(4)
		delay;
		
		reset_n = 1;
		
		delay;
		delay;
		// Simple Read from location
		rd_cpu = 1'd1;
		addr_cpu = 16'b 0000_0000_1001_0011;
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd1;
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd0;
		delay;
		delay;
		
		// Simple write to same location
		/*wr_cpu = 1'd1;
		wcpu = 8'h23;
		addr_cpu = 16'b0000_0000_1001_0011;
		delay;
		delay;
		wr_cpu = 1'd0;
		delay;
		delay;*/
		
		//Simple write Miss with dirty bit 0 policy check, reads data from Main Memory
		
		/*delay;
		wr_cpu = 1'd1;
		wcpu = 8'h88;
		addr_cpu = 16'b1100_0000_1000_0011;//1100_0000_1000_1011
		dcpu = data_cpu;
		delay;
		wr_cpu = 1'd1;
		dcpu = data_cpu;
		@(posedge rd_mem);
		ready_mem = 0;
		repeat(4)
		delay;
		
		ready_mem = 1;
		
		delay;
		
		dmem = 8'h11;
		
		delay;
		
		dmem = 8'h22;
		
		delay;
		
		dmem = 8'h33;
		
		delay;
		
		dmem = 8'h44;
		
		delay;
		
		delay;
		
		delay;
		
		delay;
		
		rd_cpu = 1'd0;*/
		
                // Simple write miss to same location
	/*	wr_cpu = 1'd1;
		wcpu = 8'h23;
		addr_cpu = 16'b0000_0001_1001_0011;
		delay;
		delay;
		wr_cpu = 1'd0;
		delay;
		delay;
		// Simple Read from same location to check updated data
		rd_cpu = 1'd1;
		addr_cpu = 16'b0000_0000_1001_0011;Simple Read Miss with dirty bit 0 policy check, reads data from Main Memory
		
		delay;
		rd_cpu = 1'd1;
		addr_cpu = 16'b1100_0000_1000_0011;//1100_0000_1000_1011
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd1;
		dcpu = data_cpu;
		@(posedge rd_mem);
		ready_mem = 0;
		repeat(4)
		delay;
		
		ready_mem = 1;
		
		delay;
		
		dmem = 8'h11;
		
		delay;
		
		dmem = 8'h22;
		
		delay;
		
		dmem = 8'h33;
		
		delay;
		
		dmem = 8'h44;
		
		delay;
		
		delay;
		
		delay;
		
		delay;
		
		rd_cpu = 1'd0;
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd1;
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd0;
		delay;
		
		// 
		

       // Simple Read Miss with dirty bit 0 policy check, reads data from Main Memory
		
		delay;
		rd_cpu = 1'd1;
		addr_cpu = 16'b1100_1000_1001_1011;//1100_0000_1000_1011
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd1;
		dcpu = data_cpu;
		@(posedge rd_mem);
		ready_mem = 0;
		repeat(4)
		delay;
		
		ready_mem = 1;
		
		delay;
		
		dmem = 8'h22;
		
		delay;
		
		dmem = 8'h11;
		
		delay;
		
		dmem = 8'h22;
		
		delay;
		
		dmem = 8'h11;
		
		delay;
		
		delay;
		
		delay;
		
		delay;
		
		rd_cpu = 1'd0;
		// Simple Read Miss Eviction Policy Test
		
		delay;
		rd_cpu = 1'd1;
		addr_cpu = 16'b1100_0001_0001_1010;
		dcpu = data_cpu;
		delay;
		rd_cpu = 1'd1;
		dcpu = data_cpu;
		@(posedge wr_mem);
		ready_mem = 0;
		repeat(4)
		delay;
		
		ready_mem = 1;
		
		@(posedge rd_mem);
		ready_mem = 0;
		repeat(4)
		delay;
		
		ready_mem = 1;
		
		delay;
		
		dmem = 8'hAA;
		
		delay;
		
		dmem = 8'hBB;
		
		delay;
		
		dmem = 8'hCC;
		
		delay;
		
		dmem = 8'hDD;
		
		delay;
		
		delay;
		
		delay;
		
		delay;
		
		rd_cpu = 1'd0;
		
		repeat(10)
		delay;
		*/
		
		// End of Simulation
		#100 $finish;

	end
      
endmodule

