module alu (
    input [7:0] a, b,          // 8-bit inputs
    input [1:0] op,            // Operation selector
    output reg [15:0] result,  // 16-bit result for mul/div
    output reg error           // Error flag for divide by zero
);
    always @(*) begin
        error = 0;
        case (op)
            2'b00: result = a + b;                     // Addition
            2'b01: result = a - b;                     // Subtraction
            2'b10: result = a * b;                     // Multiplication
            2'b11: result = (b != 0) ? a / b : 16'h0;  // Division
            default: result = 16'h0;
        endcase
        if (op == 2'b11 && b == 0)
            error = 1;  // Set error flag for divide by zero
    end
endmodule
