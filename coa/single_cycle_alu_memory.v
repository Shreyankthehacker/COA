module single_cycle_alu_memory (
    input clk, rst, start,
    input [1:0] op,                // Operation selector (ALU: 00-10, DIV: 11)
    input [1:0] mem_op,            // Memory operation selector (00: None, 01: Write, 10: Read)
    input [7:0] addr,              // Memory address
    input [7:0] in_a, in_b,        // ALU inputs
    input [7:0] write_data,        // Data to write to memory
    output reg [15:0] result,      // ALU result or memory read data
    output reg error,              // Error flag (e.g., divide by zero)
    output reg done                // Done signal
);
    reg [7:0] memory [0:255];      // 256 x 8-bit memory

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            result <= 0;
            error <= 0;
            done <= 0;
        end else if (start) begin
            done <= 0;
            error <= 0;

            // Perform memory operations first
            if (mem_op == 2'b01) begin
                // Write to memory
                memory[addr] <= write_data;
                done <= 1;
            end else if (mem_op == 2'b10) begin
                // Read from memory
                result <= memory[addr];
                done <= 1;
            end else begin
                // Perform ALU operations
                case (op)
                    2'b00: result <= in_a + in_b;                     // Addition
                    2'b01: result <= in_a - in_b;                     // Subtraction
                    2'b10: result <= in_a * in_b;                     // Multiplication
                    2'b11: begin
                        if (in_b != 0)
                            result <= in_a / in_b;                    // Division
                        else begin
                            result <= 16'hFFFF;                       // Error code for divide by zero
                            error <= 1;
                        end
                    end
                    default: result <= 16'h0;
                endcase
                done <= 1;
            end
        end
    end
endmodule
