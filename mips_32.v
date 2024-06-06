module mips_32 (
    input clk,
    input reset,
    output [31:0] pc_out,
    output [31:0] alu_result
);
    wire [31:0] pc_in;
    wire [31:0] pc_next;
    wire [31:0] instr;
    wire [31:0] reg_data1;
    wire [31:0] reg_data2;
    wire [31:0] sign_ext_imm;
    wire [31:0] alu_in2;
    wire [31:0] mem_data;
    wire [31:0] write_data;
    wire [2:0] alu_control;
    wire zero;
    wire branch;
    wire jump;
    wire mem_read;
    wire mem_write;
    wire alu_src;
    wire reg_write;
    wire [1:0] reg_dst;
    wire [1:0] mem_to_reg;
    wire [1:0] alu_op;
    wire sign_or_zero;
    wire [4:0] write_reg;
    wire jr_control;  // Señal de control para jr

    // PC logic
    reg [31:0] pc;
    assign pc_out = pc;

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= pc_in;
    end

    // Instruction memory
    instr_mem im (
        .pc(pc),
        .instruction(instr)
    );

    // Control unit
    control cu (
        .opcode(instr[31:26]),
        .reset(reset),
        .reg_dst(reg_dst),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .jump(jump),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .sign_or_zero(sign_or_zero)
    );

    // JR Control
    JR_Control jrc (
        .opcode(instr[31:26]),
        .funct(instr[5:0]),
        .jr_control(jr_control)
    );

    // Register file
    reg_file rf (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(instr[25:21]),
        .read_reg2(instr[20:16]),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Sign extend immediate
    assign sign_ext_imm = sign_or_zero ? {{16{instr[15]}}, instr[15:0]} : {16'b0, instr[15:0]};

    // ALU control unit
    ALUControl alu_ctrl (
        .alu_op(alu_op),
        .funct(instr[5:0]),
        .alu_control(alu_control)
    );

    // ALU
    assign alu_in2 = alu_src ? sign_ext_imm : reg_data2;

    alu alu (
        .a(reg_data1),
        .b(alu_in2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero)
    );

    // Data memory
    data_memory dm (
        .clk(clk),
        .mem_access_addr(alu_result),
        .mem_write_data(reg_data2),
        .mem_write_en(mem_write),
        .mem_read(mem_read),
        .mem_read_data(mem_data)
    );

    // Write data logic
    assign write_data = mem_to_reg == 2'b00 ? alu_result : mem_to_reg == 2'b01 ? mem_data : pc + 32'b1;
    assign write_reg = reg_dst == 2'b00 ? instr[20:16] : reg_dst == 2'b01 ? instr[15:11] : 5'b11111;

    // Next PC logic
    assign pc_next = pc + 32'b1;
    assign pc_in = jr_control ? reg_data1 : (jump ? {pc[31:28], instr[25:0], 2'b00} : (branch & zero ? pc_next + sign_ext_imm : pc_next));

endmodule