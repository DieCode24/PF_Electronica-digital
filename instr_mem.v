module instr_mem (
    input [31:0] pc,
    output reg [31:0] instruction
);
    reg [31:0] mem [255:0];

    initial begin
        mem[0] = 32'hXXXXXXXX;  // Instrucción en hexadecimal desde la Hoja3
        mem[1] = 32'hXXXXXXXX;  // Instrucción en hexadecimal desde la Hoja3
        mem[2] = 32'hXXXXXXXX;  // Instrucción en hexadecimal desde la Hoja3
        mem[3] = 32'hXXXXXXXX;  // Instrucción en hexadecimal desde la Hoja3
        // Continuar para todos los valores necesarios
    end

    always @(pc) begin
        instruction = mem[pc[9:2]];  // Direccionamiento correcto para 32 bits
    end
endmodule