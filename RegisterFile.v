module RegisterFile(
    input clk,
    input reg_write,
    input

 [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] regfile [31:0];

    // Initialize register file
    initial begin
        regfile[0] = 32'd0;
        regfile[1] = 32'd0;
        regfile[2] = 32'd0;
        regfile[3] = 32'd0;
        regfile[4] = 32'd0;
        regfile[5] = 32'd0;
        regfile[6] = 32'd0;
        regfile[7] = 32'd0;
        regfile[8] = 32'd5;
        regfile[9] = 32'd5;
        regfile[10] = 32'd5;
        regfile[11] = 32'd0;
        regfile[12] = 32'd0;
        regfile[13] = 32'd0;
        regfile[14] = 32'd0;
        regfile[15] = 32'd0;
        regfile[16] = 32'd0;
        regfile[17] = 32'd0;
        regfile[18] = 32'd0;
        regfile[19] = 32'd0;
        regfile[20] = 32'd0;
        regfile[21] = 32'd0;
        regfile[22] = 32'd0;
        regfile[23] = 32'd0;
        regfile[24] = 32'd0;
        regfile[25] = 32'd5;
        regfile[26] = 32'd0;
        regfile[27] = 32'd0;
        regfile[28] = 32'd0;
        regfile[29] = 32'd0;
        regfile[30] = 32'd0;
        regfile[31] = 32'd0;
    end

    // Read operations
    assign read_data1 = regfile[read_reg1];
    assign read_data2 = regfile[read_reg2];

    // Write operation
    always @(posedge clk) begin
        if (reg_write)
            regfile[write_reg] <= write_data;
    end
endmodule