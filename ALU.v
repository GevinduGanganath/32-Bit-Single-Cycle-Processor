module ALU (
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,

    output reg [31:0] result,
    output reg zero, L, LU
);

always @ (a or b or alu_control) 
begin
    case (alu_control)
        4'b0010: result = a+b; //ADD
        4'b0110: result = a-b; //SUB
        4'b0000: result = a&b; //AND
        4'b0001: result = a|b; //OR
        4'b0011: result = a^b; //XOR
        4'b0100: result = a<<b[4:0]; //Left shift
        4'b0101: result = a>>b[4:0]; //Right shift
        4'b0111: result = $signed(a)>>>b[4:0]; //Arithmatic right shift
        4'b1000: if ($signed(a) < $signed(b)) result = 1; else result = 0;  //SLT
        4'b1001: if (a < b) result = 1; else result = 0;  //SLTU
        default: result = a+b; //ADD
    endcase
    begin
        if (result == 32'd0) zero = 1'b1;
        else zero = 1'b0;
    end
    begin
        if (result == 1) L = 1'b1;
        else L = 1'b0;
    end
    begin
        if (result == 1) LU = 1'b1;
        else LU = 1'b0;
    end
end
    
endmodule