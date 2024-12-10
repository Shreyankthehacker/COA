module tb_multicycle_arithmetic;
    reg clk, rst, start;
    reg [1:0] op;
    reg [7:0] a, b;
    wire done;
    wire [15:0] result;

    multicycle_arithmetic uut(clk, rst, start, op, a, b, done, result);

    initial begin
        // Clock generation
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Test cases
        rst = 1; start = 0; a = 0; b = 0; op = 0;
        #10 rst = 0;

        // Test Addition
        #10 start = 1; op = 2'b00; a = 8'd15; b = 8'd10;
        #10 start = 0;

        // Wait for operation to complete
        wait(done);
        #10;

        // Test Subtraction
        start = 1; op = 2'b01; a = 8'd20; b = 8'd5;
        #10 start = 0;

        wait(done);
        #10;

        // Test Multiplication
        start = 1; op = 2'b10; a = 8'd4; b = 8'd3;
        #10 start = 0;

        wait(done);
        #10;

        // Test Division
        start = 1; op = 2'b11; a = 8'd40; b = 8'd8;
        #10 start = 0;

        wait(done);
        #10;

        $finish;
    end
endmodule

