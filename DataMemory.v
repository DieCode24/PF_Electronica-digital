module DataMemory(
    input clk,
    input mem_write,
    input mem_read,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [0:127];

    // Inicializar la memoria de datos
    initial begin
        memory[0] = 32'hB4080064;   // Instrucción 0: X"B4080064"
        memory[1] = 32'hB7090064;   // Instrucción 1: X"B7090064"
        memory[2] = 32'h01095023;   // Instrucción 2: X"01095023"
        memory[3] = 32'hBC0A0000;   // Instrucción 3: X"BC0A0000"
        memory[4] = 32'h0338C823;   // Instrucción 4: X"0338C823"
        memory[5] = 32'hB7280064;   // Instrucción 5: X"B7280064"
        memory[6] = 32'h035BC823;   // Instrucción 6: X"035BC823"
        memory[7] = 32'hB3290064;   // Instrucción 7: X"B3290064"
        memory[8] = 32'h01095025;   // Instrucción 8: X"01095025"
        memory[9] = 32'hBC0A0032;   // Instrucción 9: X"BC0A0032"
        memory[10] = 32'hB4080000;  // Instrucción 10: X"B4080000"
        memory[11] = 32'hB4090032;  // Instrucción 11: X"B4090032"
        memory[12] = 32'h01095023;  // Instrucción 12: X"01095023"
        memory[13] = 32'h00000000;  // Instrucción 13: X"00000000"

        // Inicializar las posiciones de memoria restantes con ceros
        for (int i = 14; i < 128; i = i + 1) begin
            memory[i] = 32'h00000000;
        end
    end

    // Operación de escritura
    always @(posedge clk) begin
        if (mem_write)
            memory[address[6:2]] <= write_data;
    end

    // Operación de lectura
    assign read_data = (mem_read) ? memory[address[6:2]] : 32'b0;
endmodule