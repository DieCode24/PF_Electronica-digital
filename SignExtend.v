module SignExtend(
    input [15:0] instruction,
    output [31:0] sign_ext_immediate
);
    assign sign_ext_immediate = {{16{instruction[15]}}, instruction};
endmodule