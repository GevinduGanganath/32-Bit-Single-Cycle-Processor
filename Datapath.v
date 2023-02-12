module Datapath (
    input clk,
    input [1:0] ALUOp,
    input BEQ, BNE, BLT, BGE, BGEU, BLTU, JALR,
    input MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output [6:0] Opcode,
    output [2:0] funct3
); 
    reg [5:0] pc;
    reg [5:0] pc_temp;
    reg [9:0] branch_control;
    reg [31:0] read_data_2;
    wire [31:0] instruction;
    wire [4:0] reg_write_addr;
    reg [31:0] reg_write_data;
    wire [4:0] reg_read_addr_1;
    wire [31:0] reg_read_data_1;
    wire [4:0] reg_read_addr_2;
    wire [31:0] reg_read_data_2;
    reg [31:0] extend_immediate;
    wire [3:0] alu_control;
    wire [31:0] alu_out;
    wire [31:0] mem_read_data;
    wire zero, L, LU;

    initial pc <= 6'd0;

    Instruction_memory IM(.pc(pc), 
                          .instruction(instruction)
                          );

    assign Opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign reg_write_addr = instruction[11:7];
    assign reg_read_addr_1 = instruction[19:15];
    assign reg_read_addr_2 = instruction[24:20];

    reg_file RF(.clk(clk),
                .reg_write_en(RegWrite),
                .reg_write_addr(reg_write_addr),
                .reg_write_data(reg_write_data),
                .reg_read_addr_1(reg_read_addr_1),
                .reg_read_data_1(reg_read_data_1),
                .reg_read_addr_2(reg_read_addr_2),
                .reg_read_data_2(reg_read_data_2)
                );
    
    ALU_control_unit ALUCU(.ALUOp(ALUOp),
                        .funct3(instruction[14:12]),
                        .funct7(instruction[30]),
                        .alu_control(alu_control)
                        );

    always @ (*)
    begin
        case (Opcode)
            7'b0000011: extend_immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b0010011: extend_immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b1100111: extend_immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b0100011: extend_immediate = {{20{instruction[31]}}, instruction[31:25] ,instruction[11:7]};
            7'b1100011: extend_immediate = {{21{instruction[31]}}, instruction[7] ,instruction[30:25], instruction[11:8]};
            default: extend_immediate = {{20{instruction[31]}}, instruction[31:20]};
        endcase
        
    end                 
  
    always @ (*)
    begin
        if (ALUSrc == 1'b0) read_data_2 = reg_read_data_2;
        else read_data_2 = extend_immediate;
    end

    ALU alu(.a(reg_read_data_1),
            .b(read_data_2),
            .alu_control(alu_control),
            .result(alu_out),
            .zero(zero),
            .L(L),
            .LU(LU)
            );

    Data_memory DM(.mem_access_addr(alu_out[9:0]),
                   .mem_write_en(MemWrite),
                   .mem_write_data(reg_read_data_2),
                   .mem_read_en(MemRead),
                   .mem_read_data(mem_read_data)
                   );

    always @(posedge clk) 
    begin
        pc_temp = pc+extend_immediate[5:0];
        branch_control = {BEQ, BNE, BLT, BGE, BLTU, BGEU, JALR, zero, L, LU};
        casex (branch_control)
            10'b1xxxxxx1xx: pc = pc_temp;
            10'bx1xxxxx0xx: pc = pc_temp;
            10'bxx1xxxxx1x: pc = pc_temp;
            10'bxxx1xxxx0x: pc = pc_temp;
            10'bxxxx1xxxx1: pc = pc_temp;
            10'bxxxxx1xxx0: pc = pc_temp;
            10'bxxxxxx1xxx: pc = pc+alu_out[5:0];
            default: pc = pc+1;
        endcase
    end
    
    always @ (*)
    begin
        if (MemtoReg == 1'b0)  reg_write_data = alu_out;
        else  reg_write_data = mem_read_data;
    end

endmodule