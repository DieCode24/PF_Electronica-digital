module MIPS(
    input clk,
    input reset,
    input step
);
    reg prev_step;
    wire step_pulse;

    // Detectar flanco ascendente en la señal step
    always @(posedge clk or posedge reset) begin
        if (reset)
            prev_step <= 1'b0;
        else
            prev_step <= step;
    end

    assign step_pulse = step & ~prev_step;

    wire [31:0] pc_in, pc_out, instruction, read_data1, read_data2, sign_ext_immediate;
    wire [31:0] alu_result, mem_data, write_data;
    wire [4:0] write_reg;
    wire [3:0] alu_control;
    wire [1:0] alu_op;
    wire mem_read, mem_write, reg_write, alu_src, reg_dst, mem_to_reg, branch;

    // Reloj controlado por step_pulse
    wire gated_clk = step_pulse;

    PC pc(
        .clk(gated_clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    InstructionMemory imem(
        .pc(pc_out),
        .instruction(instruction)
    );

    ControlUnit control(
        .opcode(instruction[31:26]),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_op(alu_op)
    );

    RegisterFile regfile(
        .clk(gated_clk),
        .reg_write(reg_write),
        .read_reg1(instruction[25:21]),
        .read_reg2(instruction[20:16]),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    SignExtend se(
        .instruction(instruction[15:0]),
        .sign_ext_immediate(sign_ext_immediate)
    );

    ALUControl alu_control_unit(
        .alu_op(alu_op),
        .funct(instruction[5:0]),
        .alu_control(alu_control)
    );

    ALU alu(
        .alu_control(alu_control),
        .input1(read_data1),
        .input2(alu_src ? sign_ext_immediate : read_data2),
        .alu_result(alu_result)
    );

    DataMemory dmem(
        .clk(gated_clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(mem_data)
    );

    MUX2to1 #(5) reg_dst_mux(
        .sel(reg_dst),
        .a(instruction[20:16]),
        .b(instruction[15:11]),
        .y(write_reg)
    );

    MUX2to1 #(32) mem_to_reg_mux(
        .sel(mem_to_reg),
        .a(alu_result),
        .b(mem_data),
        .y(write_data)
    );

    // Lógica del PC
    assign pc_in = pc_out + 4;
endmodule