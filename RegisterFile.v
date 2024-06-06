module RegisterFile(
    input clk,
    input reg_write,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] regfile [31:0];

    // Inicializar el banco de registros
    initial begin
        regfile[0] = 32'h00000000;  // Registro $0 = 0 (Constante 0)
        regfile[1] = 32'h00000000;  // Registro $1 = 0 (Reservado para ensamblador)
        regfile[2] = 32'h00000000;  // Registro $2 = 0 (Evaluación de expresión y resultado de función)
        regfile[3] = 32'h00000000;  // Registro $3 = 0 (Evaluación de expresión y resultado de función)
        regfile[4] = 32'h00000000;  // Registro $4 = 0 (Argumento 1)
        regfile[5] = 32'h00000000;  // Registro $5 = 0 (Argumento 2)
        regfile[6] = 32'h00000000;  // Registro $6 = 0 (Argumento 3)
        regfile[7] = 32'h00000000;  // Registro $7 = 0 (Argumento 4)
        regfile[8] = 32'h00000005;  // Registro $8 = 5 (Temporal, no preservado a través de llamada)
        regfile[9] = 32'h00000005;  // Registro $9 = 5 (Temporal, no preservado a través de llamada)
        regfile[10] = 32'h00000005; // Registro $10 = 5 (Temporal, no preservado a través de llamada)
        regfile[11] = 32'h00000000; // Registro $11 = 0 (Temporal, no preservado a través de llamada)
        regfile[12] = 32'h00000000; // Registro $12 = 0 (Temporal, no preservado a través de llamada)
        regfile[13] = 32'h00000000; // Registro $13 = 0 (Temporal, no preservado a través de llamada)
        regfile[14] = 32'h00000000; // Registro $14 = 0 (Temporal, no preservado a través de llamada)
        regfile[15] = 32'h00000000; // Registro $15 = 0 (Temporal, no preservado a través de llamada)
        regfile[16] = 32'h00000000; // Registro $16 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[17] = 32'h00000000; // Registro $17 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[18] = 32'h00000000; // Registro $18 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[19] = 32'h00000000; // Registro $19 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[20] = 32'h00000000; // Registro $20 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[21] = 32'h00000000; // Registro $21 = 0 (Guardado temporalmente, preservado a través de llamada)
        regfile[22] = 32'h00000008; // Registro $22 = 8 (Guardado temporalmente, preservado a través de llamada)
        regfile[23] = 32'h00000007; // Registro $23 = 7 (Guardado temporalmente, preservado a través de llamada)
        regfile[24] = 32'h00000004; // Registro $24 = 4 (Temporal, no preservado a través de llamada)
        regfile[25] = 32'h00000008; // Registro $25 = 8 (Temporal, no preservado a través de llamada)
        regfile[26] = 32'h00000003; // Registro $26 = 3 (Reservado para núcleo SO)
        regfile[27] = 32'h00000002; // Registro $27 = 2 (Reservado para núcleo SO)
        regfile[28] = 32'h00000000; // Registro $28 = 0 (Puntero a área global)
        regfile[29] = 32'h00000000; // Registro $29 = 0 (Puntero de pila)
        regfile[30] = 32'h00000000; // Registro $30 = 0 (Puntero de encuadre)
        regfile[31] = 32'h00000000; // Registro $31 = 0 (Dirección de vuelta, usada por llamada a función)
    end

    // Operaciones de lectura
    assign read_data1 = regfile[read_reg1]; // Lee el valor del registro especificado en read_reg1
    assign read_data2 = regfile[read_reg2]; // Lee el valor del registro especificado en read_reg2

    // Operación de escritura
    always @(posedge clk) begin
        if (reg_write) // Si la señal reg_write está activa
            regfile[write_reg] <= write_data; // Escribe el valor de write_data en el registro especificado en write_reg
    end
endmodule