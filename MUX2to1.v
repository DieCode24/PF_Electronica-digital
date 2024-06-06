module MUX2to1 #(parameter WIDTH = 32)(
    input sel,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] y
);
    assign y = (sel) ? b : a;
endmodule