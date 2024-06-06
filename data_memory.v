module data_memory (
    input clk,
    input [31:0] mem_access_addr,
    input [31:0] mem_write_data,
    input mem_write_en,
    input mem_read,
    output [31:0] mem_read_data
);
    reg [31:0] ram [255:0];

    initial begin
        ram[0] = 32'hXXXXXXXX;  // Dato en hexadecimal desde la Hoja3
        ram[1] = 32'hXXXXXXXX;  // Dato en hexadecimal desde la Hoja3
        ram[2] = 32'hXXXXXXXX;  // Dato en hexadecimal desde la Hoja3
        ram[3] = 32'hXXXXXXXX;  // Dato en hexadecimal desde la Hoja3
        // Continuar para todos los valores necesarios
    end

    always @(posedge clk) begin
        if (mem_write_en)
            ram[mem_access_addr[9:2]] <= mem_write_data;
    end

    assign mem_read_data = (mem_read == 1'b1) ? ram[mem_access_addr[9:2]] : 32'd0;
endmodule