`timescale 1ns / 1ps

module tb_mips32;

    reg clk;
    reg reset;
    
    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] mem_data;
    wire [31:0] write_data;
    wire [4:0] write_reg;
    wire mem_read, mem_write, reg_write, alu_src, reg_dst, mem_to_reg, branch;
    wire [1:0] alu_op;

    // Instanciación del módulo MIPS
    MIPS uut(
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .instruction(instruction),
        .alu_result(alu_result),
        .mem_data(mem_data),
        .write_data(write_data),
        .write_reg(write_reg),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .reg_dst(reg_dst),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    // Inicialización de registros
    initial begin
        // Iniciar reloj y reset
        clk = 0;
        reset = 1;
        #10 reset = 0;
        
        // Inicializar registros si es necesario
        uut.reg_file.regs[1] = 32'd5;
        uut.reg_file.regs[2] = 32'd10;
        
        // Ejecutar pruebas después de un tiempo de espera
        #100;
        
        // Ejemplo de prueba para la instrucción ADD
        // Se espera que reg[3] contenga el valor 15 después de la ejecución
        $display("Prueba: ADD - Se espera que reg[3] contenga 15");
        
        // Instrucción ADD: $3 = $1 + $2
        // Se espera que reg[3] contenga 15 (5 + 10)
        #20;
        // Mostrar el valor esperado y el valor real
        $display("Reg[3]: %h (Valor esperado: 0000000F)", uut.reg_file.regs[3]);
        
        // Más pruebas pueden agregarse de manera similar
        
        // Terminar la simulación después de un tiempo suficiente
        #500;
        $finish;
    end

    // Simular el reloj
    always #5 clk = ~clk;

endmodule
