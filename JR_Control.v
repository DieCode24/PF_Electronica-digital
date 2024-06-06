module JR_Control(
    input [5:0] opcode,   // Opcode de la instrucción
    input [5:0] funct,    // Código de función (campo func en instrucciones tipo R)
    output reg jr_control // Señal de control para la instrucción jr
);

    always @(*) begin
        if (opcode == 6'b000000 && funct == 6'b001000) begin
            jr_control = 1'b1; // jr (jump register)
        end else begin
            jr_control = 1'b0; // No es una instrucción jr
        end
    end

endmodule