module reg_file (
    input clk,
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] reg_array [31:0];

    always @(posedge clk) begin
        if (reg_write)
            reg_array[write_reg] <= write_data;
    end

    assign read_data1 = reg_array[read_reg1];
    assign read_data2 = reg_array[read_reg2];
endmodule