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
        // Inicializar las posiciones de memoria restantes con ceros
        for (int i = 0; i < 100; i = i + 1) begin
            memory[i] = 32'h00000000;
        end

        // Asignar los datos proporcionados
        memory[100] = 32'h000000EA; // Dato 100: X"000000EA"
        memory[101] = 32'h000001C8; // Dato 101: X"000001C8"
        memory[102] = 32'h00000315; // Dato 102: X"00000315"
        memory[103] = 32'h00000022; // Dato 103: X"00000022"
        memory[104] = 32'h0000093D; // Dato 104: X"0000093D"
        memory[105] = 32'h000002E9; // Dato 105: X"000002E9"
        memory[106] = 32'h00001407; // Dato 106: X"00001407"
        memory[107] = 32'h00000005; // Dato 107: X"00000005"
        memory[108] = 32'h0000021F; // Dato 108: X"0000021F"
        memory[109] = 32'h000002B1; // Dato 109: X"000002B1"
        memory[110] = 32'h000002E9; // Dato 110: X"000002E9"
        memory[111] = 32'h0000034E; // Dato 111: X"0000034E"
        memory[112] = 32'h00000139; // Dato 112: X"00000139"
        memory[113] = 32'h00000243; // Dato 113: X"00000243"
        memory[114] = 32'h000000C3; // Dato 114: X"000000C3"
        memory[115] = 32'h00001098; // Dato 115: X"00001098"
        memory[116] = 32'h00000054; // Dato 116: X"00000054"
        memory[117] = 32'h0000116E; // Dato 117: X"0000116E"
        memory[118] = 32'h000014CB; // Dato 118: X"000014CB"
        memory[119] = 32'h000001A5; // Dato 119: X"000001A5"
        memory[120] = 32'h00000001; // Dato 120: X"00000001"
        memory[121] = 32'h00000238; // Dato 121: X"00000238"
        memory[122] = 32'h00000000; // Dato 122: X"00000000"
        memory[123] = 32'h000002FC; // Dato 123: X"000002FC"
        memory[124] = 32'h000000CE; // Dato 124: X"000000CE"
        memory[125] = 32'h000025E4; // Dato 125: X"000025E4"
        memory[126] = 32'h00000158; // Dato 126: X"00000158"
        memory[127] = 32'h000008C5; // Dato 127: X"000008C5"
    end

    // Operación de escritura
    always @(posedge clk) begin
        if (mem_write)
            memory[address[6:2]] <= write_data;
    end

    // Operación de lectura
    assign read_data = (mem_read) ? memory[address[6:2]] : 32'b0;
endmodule