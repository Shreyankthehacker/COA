`timescale 1ns/1ps

module alu_tb;
    reg [7:0] a, b;            // Inputs to ALU
    reg [1:0] op;              // Operation selector
    wire [15:0] result;        // ALU result
    wire error;                // Error flag

    alu uut (                  // Instantiate the ALU module
        .a(a), 
        .b(b), 
        .op(op), 
        .result(result), 
        .error(error)
    );

    initial begin
        // Dump waveform for GTKWave
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Test addition
        a = 8'd10; b = 8'd20; op = 2'b00; #10;
        
        // Test subtraction
        a = 8'd30; b = 8'd15; op = 2'b01; #10;

        // Test multiplication
        a = 8'd5; b = 8'd3; op = 2'b10; #10;

        // Test division
        a = 8'd40; b = 8'd8; op = 2'b11; #10;

        // Test division by zero
        a = 8'd40; b = 8'd0; op = 2'b11; #10;

        $finish;  // End simulation
    end
endmodule
