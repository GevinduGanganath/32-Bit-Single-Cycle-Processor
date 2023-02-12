module Processor (
    input clk
);
    wire MemRead, MemWrite, ALUSrc, MemtoReg, RegWrite, BEQ, BNE, BGE, BLT, BGEU, BLTU, JALR;
    wire [1:0] ALUOp;
    wire [6:0] Opcode;
    wire [2:0] funct3;

    Datapath D(.clk(clk),
               .ALUOp(ALUOp),
               .Opcode(Opcode),
               .funct3(funct3),
               .MemRead(MemRead),
               .MemtoReg(MemtoReg),
               .MemWrite(MemWrite),
               .ALUSrc(ALUSrc),
               .RegWrite(RegWrite),
               .BEQ(BEQ),
               .BNE(BNE),
               .BLT(BLT),
               .BGE(BGE),
               .BLTU(BLTU),
               .BGEU(BGEU),
               .JALR(JALR)
                );
    
    Control_unit CU(.clk(clk),
                    .ALUOp(ALUOp),
                    .Opcode(Opcode),
                    .funct3(funct3),
                    .MemRead(MemRead),
                    .MemtoReg(MemtoReg),
                    .MemWrite(MemWrite),
                    .ALUSrc(ALUSrc),
                    .RegWrite(RegWrite),
                    .BEQ(BEQ),
                    .BNE(BNE),
                    .BLT(BLT),
                    .BGE(BGE),
                    .BLTU(BLTU),
                    .BGEU(BGEU),
                    .JALR(JALR)
                    );
endmodule