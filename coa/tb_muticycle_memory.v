module tb_multicycle_memory;
    reg clk, rst, start;
    reg [1:0] op;
    reg [7:0] addr, write_data;
    wire done;
    wire [7:0] read_data;

    multicycle_memory uut(clk, rst, start, op, addr, write_data, done, read_data);

    initial begin
        // Clock generation
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Test cases
        rst = 1; start = 0; addr = 0; write_data = 0; op = 0;
        #10 rst = 0;

        // Write to memory
        #10 start = 1; op = 2'b00; addr = 8'd10; write_data = 8'd42;
        #10 start = 0;

        // Wait for write to complete
        wait(done);
        #10;

        // Read from memory
        start = 1; op = 2'b01; addr = 8'd10;
        #10 start = 0;

        // Wait for read to complete
        wait(done);
        #10;

        $finish;
    end

    initial begin
        $dumpfile("memory_dump.vcd");
        $dumpvars(0, tb_multicycle_memory);
    end
endmodule