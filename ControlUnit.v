module ControlUnit(
    input [5:0] opcode,
    output reg_dst,
    output alu_src,
    output mem_to_reg,
    output reg_write,
    output mem_read,
    output mem_write,
    output branch,
    output [1:0] alu_op
);
    // Control signals logic based on opcode
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter R_TYPE = 6'b000000;

    always @(*) begin
        case (opcode)
            LW: begin
                reg_dst = 1'b0;
                alu_src = 1'b1;
                mem_to_reg = 1'b1;
                reg_write = 1'b1;
                mem_read = 1'b1;
                mem_write = 1'b0;
                branch = 1'b0;
                alu_op = 2'b00;
            end
            SW: begin
                reg_dst = 1'bx;
                alu_src = 1'b1;
                mem_to_reg = 1'bx;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b1;
                branch = 1'b0;
                alu_op = 2'b00;
            end
            R_TYPE: begin
                reg_dst = 1'b1;
                alu_src = 1'b0;
                mem_to_reg = 1'b0;
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                alu_op = 2'b10;
            end
            default: begin
                reg_dst = 1'b0;
                alu_src = 1'b0;
                mem_to_reg = 1'b0;
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                alu_op = 2'b00;
            end
        endcase
    end
endmodule