module Instruction_memory(
 input [5:0] pc,
 output [31:0] instruction
);

 reg [31:0] I_memory [63:0];

 initial
 begin
    $readmemb("test_case_1.mem", I_memory, 0, 63);
 end
 assign instruction =  I_memory[pc]; 

endmodule