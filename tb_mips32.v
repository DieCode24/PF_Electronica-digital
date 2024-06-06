module tb_mips32;
    reg clk;
    reg reset;
    wire [31:0] pc_out;
    wire [31:0] alu_result;

    mips_32 uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .alu_result(alu_result)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        reset = 1;
        #100;
        reset = 0;

        // Afirmaciones para validar la memoria de datos
        #200;
        $display("Mem[0]: %h", uut.dm.ram[0]);  // Esperado: 0000
        $display("Mem[1]: %h", uut.dm.ram[1]);  // Esperado: 0000
        $display("Mem[2]: %h", uut.dm.ram[2]);  // Esperado: 0000
        $display("Mem[3]: %h", uut.dm.ram[3]);  // Esperado: 0000

        // Afirmaciones para validar los registros
        // Agregar código aquí para verificar los valores de los registros

        // Finalizar la simulación
        #500;
        $finish;
    end
endmodule