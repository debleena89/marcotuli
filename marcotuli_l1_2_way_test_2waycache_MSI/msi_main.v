module msi_main(
	input clk,reset_n,ready_mem
);
	wire core1_read, core2_read;//Cores outputs
	wire core1_write, core2_write;
	wire [7:0] core1_write_data;
	wire [15:0] core1_mem_adress;
	wire core1_read_data_found, core1_write_data_found;
	wire write_hit, read_hit, write_miss, read_miss;
	wire [1:0] state_in, state_out;
	
	
	wire [15:0] cache1_ask_mem_address;
	wire [7:0]cache1_address_out_mem_cpu, cache1_address_out_mem_bus;
	wire [15:0]cache1_bus_reply_data_found, cache2_bus_reply_data_found;
	wire [15:0] cache1_data_out_cpu, cache1_data_out_mem_cpu;//connections for Caches outputs
	wire [15:0] cache1_bus_reply_data_delivery, cache2_bus_reply_data_delivery, cache1_data_out_cpu, cache2_data_out_cpu, cache1_data_out_mem_cpu, cache1_data_out_mem_bus, cache2_data_out_mem_cpu, cache2_data_out_mem_bus;//connections for Caches outputs

	
	  assign state_in = 2'b0;
	  assign state_out = 2'b0;
	  
	//reg [15:0]data_mem = 4'b00;
	
	
	wire [7:0] mem_readed1, mem_readed2;//Mem outs
	ProcessorCoreA _CORE1_(//cada um com suas instrucoes separadas
		.clk(clk),
		.fetched_data(cache1_data_out_cpu),
		.read(core1_read),
		.write(core1_write),
		.write_data(core1_write_data),
		.address(core1_mem_adress)
	);
     cache_2wsa _CORE_CACHE(// #(16, 32, 32, 4, 8, 1, 1, 1, 11) _CORE1_CACHE_(
	   .clock(clk),
	   .reset_n(reset_n),
	   .data_cpu(core1_write_data),
	   //.data_mem(core1_write_data),
	   
	   .addr_cpu(core1_mem_adress),
	   //.addr_mem(core1_mem_adress),
	   
	   .rd_cpu(core1_read),
	   .wr_cpu(core1_write),
	   
	   .rd_mem(core1_read_data_found),
	   .wr_mem(core1_write_data_found),
	   
	   .ready_mem(ready_mem)
   );
   
     assign write_hit = (core1_write == 1 & core1_write_data_found == 0) ? 1 : 0;
     assign write_miss = (core1_write == 1 & core1_write_data_found == 1) ? 1 : 0;
     assign read_hit = (core1_read == 1 & core1_read_data_found == 0) ? 1 : 0;
     assign read_miss = (core1_read== 1 & core1_read_data_found == 1) ? 1 : 0; 
     
     W0_tag_read_write _W0_T_M(
      .clock(clk),
      .addr(core1_mem_adress),
      .MSI_state_in(state_out),
      .MSI_state_out(state_in)
      );
        
   
   FSM_MSI_CPU_requests_controller _CTRL_R_(
		.CPU_state_in(state_out),
		.cpu_write_hit(write_hit),.cpu_read_hit(read_hit),
		.cpu_write_miss(write_miss),.cpu_read_miss(read_miss),
		//send to mem //<-outputs:
		.CPU_state_next(state_in)//used in block
		//.bus_next(bus_reply)//writen on bus
	);
	
	
	/*cache_directlyMapped_32x21bits _CORE1_CACHE_(
		.clk(clk),.core(1'b0),

		.read(core1_read),
		.write(core1_write),
		.write_data(core1_write_data),
		.mem_address(core1_mem_adress),

		//.bus_requests(cache2_bus_reply),
		//.bus_request_mem_address(cache2_ask_mem_address),

		//.bus_data_found(cache2_bus_reply_data_found),
		//.bus_data_delivery(cache2_bus_reply_data_delivery),

		.mem_data_delivery(mem_readed1),

		.cpu_write_back(cache1_write_back_cpu),//<-outputs:
		//.bus_write_back(cache1_write_back_bus),
		.data_out_cpu(cache1_data_out_cpu),
		.data_out_mem_cpu(cache1_data_out_mem_cpu),
		//.data_out_mem_bus(cache1_data_out_mem_bus),
		.address_out_mem_cpu(cache1_address_out_mem_cpu),
	//	.address_out_mem_bus(cache1_address_out_mem_bus),

	//	.bus_reply_abort_mem_access(cache1_bus_reply_data_found),
	//	.bus_reply_data_found(cache1_bus_reply_data_delivery),

		.ask_mem_address(cache1_ask_mem_address)
	//	.bus_reply(cache1_bus_reply)
	);*/
	
/*	memory512x16bits _RAM_(
		.clk(clk),
		.address_read1(cache1_ask_mem_address), 
		.write1(core1_write), 
		.address_write1(cache1_ask_mem_address),
		.data_write1(core1_write_data), 
		.readed1(mem_readed1)	
	);*/
endmodule
