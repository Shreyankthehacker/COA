`timescale 1ns/1ps

module single_cycle_alu_memory_tb;
    reg clk, rst, start;           // Clock, reset, and start signals
    reg [1:0] op, mem_op;          // Operation selectors
    reg [7:0] addr, in_a, in_b;    // Address and ALU inputs
    reg [7:0] write_data;          // Data to write
    wire [15:0] result;            // ALU result or memory read data
    wire error, done;              // Error and done flags

    // Instantiate the module
    single_cycle_alu_memory uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .op(op),
        .mem_op(mem_op),
        .addr(addr),
        .in_a(in_a),
        .in_b(in_b),
        .write_data(write_data),
        .result(result),
        .error(error),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Dump waveform for GTKWave
        $dumpfile("single_cycle_alu_memory_tb.vcd");
        $dumpvars(0, single_cycle_alu_memory_tb);

        // Initialize signals
        clk = 0; rst = 1; start = 0; op = 0; mem_op = 0; addr = 0; in_a = 0; in_b = 0; write_data = 0;
        #10 rst = 0;

        // Memory write operation
        addr = 8'd10; write_data = 8'd42; mem_op = 2'b01; start = 1; #10 start = 0; #10;

        // Memory read operation
        addr = 8'd10; mem_op = 2'b10; start = 1; #10 start = 0; #10;

        // ALU addition
        mem_op = 2'b00; op = 2'b00; in_a = 8'd15; in_b = 8'd25; start = 1; #10 start = 0; #10;

        // ALU subtraction
        op = 2'b01; in_a = 8'd50; in_b = 8'd20; start = 1; #10 start = 0; #10;

        // ALU multiplication
        op = 2'b10; in_a = 8'd6; in_b = 8'd7; start = 1; #10 start = 0; #10;

        // ALU division
        op = 2'b11; in_a = 8'd40; in_b = 8'd8; start = 1; #10 start = 0; #10;

        // ALU division by zero
        op = 2'b11; in_a = 8'd40; in_b = 8'd0; start = 1; #10 start = 0; #10;

        $finish;  // End simulation
    end
endmodule
