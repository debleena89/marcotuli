module msi_main(
	input clk,reset_n,ready_mem
);
	wire core1_read, core2_read;//Cores outputs
	wire core1_write, core2_write;
	wire [7:0] core1_write_data, core2_write_data;
	wire [15:0] core1_mem_adress, core2_mem_adress;
	
	wire [1:0] cache1_bus_reply,cache2_bus_reply;
	wire [15:0] cache1_ask_mem_address,cache2_ask_mem_address;
	wire [7:0]cache1_address_out_mem_cpu, cache1_address_out_mem_bus, cache2_address_out_mem_cpu, cache2_address_out_mem_bus;
	wire [15:0]cache1_bus_reply_data_found, cache2_bus_reply_data_found;
	wire [15:0] cache1_bus_reply_data_delivery, cache2_bus_reply_data_delivery, cache1_data_out_cpu, cache2_data_out_cpu, cache1_data_out_mem_cpu, cache1_data_out_mem_bus, cache2_data_out_mem_cpu, cache2_data_out_mem_bus;//connections for Caches outputs

	
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
	   
	  // .rd_mem(core1_read),
	  // .wr_mem(core1_write)
	   
	   .ready_mem(ready_mem)
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
