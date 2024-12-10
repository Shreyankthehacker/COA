module multicycle_arithmetic(
    input clk, rst, start, 
    input [1:0] op, 
    input [7:0] a, b, 
    output reg done, 
    output reg [15:0] result
);
    reg [2:0] state;

    parameter IDLE = 3'b000, LOAD = 3'b001, ADD = 3'b010, SUB = 3'b011, 
              MUL = 3'b100, DIV = 3'b101, DONE = 3'b110;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            result <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) state <= LOAD;
                end
                LOAD: begin
                    case (op)
                        2'b00: state <= ADD;
                        2'b01: state <= SUB;
                        2'b10: state <= MUL;
                        2'b11: state <= DIV;
                        default: state <= DONE;
                    endcase
                end
                ADD: begin
                    result <= a + b;
                    state <= DONE;
                end
                SUB: begin
                    result <= a - b;
                    state <= DONE;
                end
                MUL: begin
                    result <= a * b;
                    state <= DONE;
                end
                DIV: begin
                    result <= (b != 0) ? a / b : 16'hFFFF; // Error code for divide by zero
                    state <= DONE;
                end
                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
