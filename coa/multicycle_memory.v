module multicycle_memory(input clk, rst, start, input [1:0] op, input [7:0] addr, input [7:0] write_data, output reg done, output reg [7:0] read_data);
    reg [2:0] state;
    reg [7:0] memory [0:255]; // 256 x 8-bit memory
    reg [7:0] temp_addr, temp_data;

    parameter IDLE = 3'b000, LOAD_ADDR = 3'b001, WRITE = 3'b010, READ = 3'b011, DONE = 3'b100;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            read_data <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        temp_addr <= addr;
                        temp_data <= write_data;
                        state <= LOAD_ADDR;
                    end
                end
                LOAD_ADDR: begin
                    case (op)
                        2'b00: state <= WRITE; // Write operation
                        2'b01: state <= READ;  // Read operation
                        default: state <= DONE;
                    endcase
                end
                WRITE: begin
                    memory[temp_addr] <= temp_data;
                    state <= DONE;
                end
                READ: begin
                    read_data <= memory[temp_addr];
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