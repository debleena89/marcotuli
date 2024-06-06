 
/*
============================
Parameterized Single Port RAM
============================
*/

// File Name:		ram_sync_read_t0.v
// Version:		0.0v
//
// Author:		Prasad Pandit & Radhika Mandlekar
// Contact:		prasad@pdx.edu, radhika@pdx.edu
//
// Date created:	11/10/2015
// Date modified:	NA
//
// Text-editor used:	Gvim 7v4
//
// Related filelist:	
//
// Description:		IP to infer single address and seperate read and write
// 			data port Synchronous Read RAM
// 			Width of Address & Data bus as well Depth of Data RAM can be
// 			configured
// 			Latching of data while writing is done at rising edge
// 			of clock
// 
// NOTE:		Printing this file to PDF may create parsing
// 			error, do verify PDF with this file for correctness of code and
// 			indentation
// ******************************************************************************************************


module W0_tag_read_write(
				input 	clock,			//Input signal for clock
				input 	[15:0] addr,	//Parameterized Address bus input				
				input 	[1:0] MSI_state_in,			//Write Enable (input HIGH = write, LOW = read)
				output  [1:0] MSI_state_out	//Parameterized Data bus output
				);

// Configuration Parameters

//parameter AWIDTH = 16;		// Address Width Parameter, also used to calculate depth
//parameter DWIDTH = 18;		// Data width parameter
//localparam DEPTH  = 1 << AWIDTH;
integer i;
// Memory Array Decaration

reg [17:0] mem_array_t0 [0:10];
wire [2:0]index;
wire [10:0]tagdata;
reg tag_match;

// Memory initialization
initial
begin
	$readmemb("/home/debleena/Thales/marcotuli_l1_2_way_test_2waycache_MSI/tagRam0.txt", mem_array_t0);
	for(i=0; i<7; i=i+1) begin
		   mem_array_t0[i] = {2'b0,mem_array_t0[i]};
    end
end

assign index = addr[4:2];
assign MSI_state_out = 2'b0;//mem_array_t0[index][17:16];


// Internal Register to latch address for synchronous read operation
//reg [AWIDTH-1:0] rd_addr;

// Sequential Block to write data in memory as well as latch read address
// depending on 'we' write enable signal
always@(posedge clock)
begin
	
		mem_array_t0[index][17:16] <= MSI_state_in;;	

		
end



//assign mem_array_t0[index][17:16] = state_in; 
 
// Data out during read operation with latched address to keep output stable
//assign state_out = mem_array_t0[rd_addr];

endmodule
