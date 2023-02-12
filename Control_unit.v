module Control_unit (
    input clk,
    input [6:0] Opcode,
    input [2:0] funct3,
    output reg [1:0] ALUOp,
    output reg BEQ, BNE, BLT, BGE, BLTU, BGEU, JALR,
    output reg MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite
);

wire [9:0] control_in;
assign control_in = {Opcode, funct3};

always @(control_in) 
begin
    casex (control_in)
        //ADD SUB AND OR XOR 
        //SLL SLT SLTU SRL SRA
        10'b0110011xxx: 
        begin
            ALUOp = 2'b10;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
        end
        //ADDI ORI ANDI
        //SLTI SLTIU SORI SLLI SRLI SRAI
        10'b0010011xxx: 
        begin
            ALUOp = 2'b10;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        //LW
        10'b0000011xxx: 
        begin
            ALUOp = 2'b00;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        //SW
        10'b0100011xxx: 
        begin
            ALUOp = 2'b00;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b1;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
        end
        //BEQ
        10'b1100011000: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b1;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //BNE
        10'b1100011001: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b0;
            BNE = 1'b1;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //BLT
        10'b1100011100: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b1;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //BGE
        10'b1100011101: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b1;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //BLTU
        10'b1100011110: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b1;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //BGEU
        10'b1100011111: 
        begin
            ALUOp = 2'b01;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b1;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //JALR
        10'b1100111000: 
        begin
            ALUOp = 2'b00;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b1;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
        end
        //Default => ADD
        default: 
        begin
            ALUOp = 2'b10;
            BEQ = 1'b0;
            BNE = 1'b0;
            BLT = 1'b0;
            BGE = 1'b0;
            BLTU = 1'b0;
            BGEU = 1'b0;
            JALR = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
        end
    endcase
end

//always @ (negedge clk) MemWrite = 1'b0;
    
endmodule