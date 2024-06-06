module control (
    input [5:0] opcode,
    input reset,
    output reg reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, jump,
    output reg [1:0] alu_op
);
    always @(*) begin
        if (reset == 1'b1) begin
            reg_dst = 1'b0;
            alu_src = 1'b0;
            mem_to_reg = 1'b0;
            reg_write = 1'b0;
            mem_read = 1'b0;
            mem_write = 1'b0;
            branch = 1'b0;
            alu_op = 2'b00;
            jump = 1'b0;
        end else begin
            case (opcode)
                6'b000000: begin // R-type
                    reg_dst = 1'b1;
                    alu_src = 1'b0;
                    mem_to_reg = 1'b0;
                    reg_write = 1'b1;
                    mem_read = 1'b0;
                    mem_write = 1'b0;
                    branch = 1'b0;
                    alu_op = 2'b10;
                    jump = 1'b0;
                end
                6'b100011: begin // lw
                    reg_dst = 1'b0;
                    alu_src = 1'b1;
                    mem_to_reg = 1'b1;
                    reg_write = 1'b1;
                    mem_read = 1'b1;
                    mem_write = 1'b0;
                    branch = 1'b0;
                    alu_op = 2'b00;
                    jump = 1'b0;
                end
                6'b101011: begin // sw
                    reg_dst = 1'bx;
                    alu_src = 1'b1;
                    mem_to_reg = 1'bx;
                    reg_write = 1'b0;
                    mem_read = 1'b0;
                    mem_write = 1'b1;
                    branch = 1'b0;
                    alu_op = 2'b00;
                    jump = 1'b0;
                end
                6'b000100: begin // beq
                    reg_dst = 1'bx;
                    alu_src = 1'b0;
                    mem_to_reg = 1'bx;
                    reg_write = 1'b0;
                    mem_read = 1'b0;
                    mem_write = 1'b0;
                    branch = 1'b1;
                    alu_op = 2'b01;
                    jump = 1'b0;
                end
                6'b000010: begin // jump
                    reg_dst = 1'bx;
                    alu_src = 1'bx;
                    mem_to_reg = 1'bx;
                    reg_write = 1'b0;
                    mem_read = 1'b0;
                    mem_write = 1'b0;
                    branch = 1'b0;
                    alu_op = 2'bxx;
                    jump = 1'b1;
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
                    jump = 1'b0;
                end
            endcase
        end
    end
endmodule