module Data_memory(
 input [9:0] mem_access_addr,
 // write port
 input mem_write_en,
 input [31:0] mem_write_data,
 // read port
 input mem_read_en,
 output reg [31:0] mem_read_data
);

 reg [31:0] D_memory [1023:0];

 initial $readmemb("Data.mem", D_memory, 0, 1023);

 always @ (*) if (mem_write_en)  D_memory[mem_access_addr] <= mem_write_data;
 always @ (*) if (mem_read_en) mem_read_data <= D_memory[mem_access_addr];

endmodule