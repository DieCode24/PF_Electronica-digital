module DataMemory(
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:127];

    initial begin
        // Initialize data memory with zeros
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 32'b0;
        end
    end

    // Write operation
    always @(posedge clk) begin
        if (mem_write)
            memory[address[6:2]] <= write_data;
    end

    // Read operation
    assign read_data = (mem_read) ? memory[address[6:2]] : 32'b0;
endmodule