module InstructionMemory(
    input [31:0] pc,
    output [31:0] instruction
);
    reg [31:0] memory [0:127];

    initial begin
        memory[0]  = 32'hB4080064; // lw $8,100($0)
        memory[1]  = 32'hB7090064; // lw $9,100($24)
        memory[2]  = 32'h01095023; // add $10,$8,$9
        memory[3]  = 32'hBC0A0000; // sw $10,0($0)
        memory[4]  = 32'h0338C823; // add $25,$24,$25
        memory[5]  = 32'hB7280064; // lw $8,100($25)
        memory[6]  = 32'h035BC823; // add $25,$26,$27
        memory[7]  = 32'hB3290064; // lw $9,100($25)
        memory[8]  = 32'h01095025; // sub $10,$8,$9
        memory[9]  = 32'hBC0A0032; // sw $10,50($0)
        memory[10] = 32'hB4080000; // lw $8,0($0)
        memory[11] = 32'hB4090032; // lw $9,50($0)
        memory[12] = 32'h01095023; // add $10,$8,$9
        memory[13] = 32'h00000000; // NOP
        // Fill the rest with NOPs
        integer i; // Corrección: Declarar la variable i como integer
        for (i = 14; i < 128; i = i + 1) begin
            memory[i] = 32'h00000000;
        end
    end

    assign instruction = memory[pc[6:2]]; // Word aligned addressing
endmodule