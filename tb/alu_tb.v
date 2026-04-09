module alu_tb;

reg [7:0] A, B;
reg [3:0] opcode;
wire [15:0] result;
wire carry, zero, overflow;

alu_8bit_full uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .carry(carry),
    .zero(zero),
    .overflow(overflow)
);

initial begin
    $display("Starting ALU Testbench");

    A = 8'd20; B = 8'd5;

    opcode = 4'b0000; #10; // ADD
    opcode = 4'b0001; #10; // SUB
    opcode = 4'b0010; #10; // MUL
    opcode = 4'b0011; #10; // DIV
    opcode = 4'b0100; #10; // AND
    opcode = 4'b0101; #10; // OR
    opcode = 4'b0110; #10; // NOT
    opcode = 4'b0111; #10; // NAND
    opcode = 4'b1000; #10; // NOR
    opcode = 4'b1001; #10; // XOR
    opcode = 4'b1010; #10; // XNOR

    $stop;
end

endmodule
