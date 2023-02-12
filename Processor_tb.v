`timescale 1 ns/10 ps

module Processor_tb ;
    reg clk;

    localparam period = 10;  
    localparam sim_time = 500;

    Processor UUT (.clk(clk));
    
    initial 
        begin
            clk <= 1'b0;
            #sim_time;
            $finish;
        end
    always
        begin
            #period;
            clk = ~clk;
        end
            
endmodule

