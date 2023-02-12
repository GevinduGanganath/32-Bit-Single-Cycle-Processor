module ALU_control_unit (
    input [1:0] ALUOp,
    input [2:0] funct3,
    input funct7,
    
    output reg [3:0] alu_control
);
    wire [5:0] ALU_control_in;
    assign ALU_control_in = {ALUOp, funct3, funct7};
    
    always @(ALU_control_in) 
    begin
        casex (ALU_control_in)
            // R type
            6'b100000: alu_control = 4'b0010;  //ADD
            6'b100001: alu_control = 4'b0110;  //SUB
            6'b101110: alu_control = 4'b0000;  //AND
            6'b101100: alu_control = 4'b0001;  //OR
            6'b101000: alu_control = 4'b0011;  //XOR
            6'b100010: alu_control = 4'b0100;  //Logic left shift
            6'b101010: alu_control = 4'b0101;  //Logic right shift
            6'b101011: alu_control = 4'b0111;  //Arithmatic right shift
            6'b10010x: alu_control = 4'b1000;  //SLT
            6'b10011x: alu_control = 4'b1001;  //SLTU
            // I, S type
            6'b00xxxx: alu_control = 4'b0010;  //LOAD, STORE
            // B type
            6'b01000x: alu_control = 4'b0110;  //BEQ
            6'b01001x: alu_control = 4'b0110;  //BNE
            6'b01100x: alu_control = 4'b1000;  //BLT
            6'b01101x: alu_control = 4'b1000;  //BGE
            6'b01110x: alu_control = 4'b1001;  //BLTU
            6'b01111x: alu_control = 4'b1001;  //BGEU
            // Default
            default: alu_control = 4'b0010;  //ADD
        endcase
        
    end
    
endmodule