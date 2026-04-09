module alu_8bit_full(
    input [7:0] A, B,
    input [3:0] opcode,
    output reg [15:0] result,
    output reg carry, zero, overflow
);

always @(*) begin
    result = 0;
    carry = 0;
    overflow = 0;

    case(opcode)
        4'b0000: {carry, result[7:0]} = A + B;   // ADD
        4'b0001: {carry, result[7:0]} = A - B;   // SUB
        4'b0010: result = A * B;                 // MUL
        
        4'b0011: begin                           // DIV
            if (B != 0)
                result[7:0] = A / B;
            else
                result = 16'hFFFF;
        end

        4'b0100: result[7:0] = A & B;            // AND
        4'b0101: result[7:0] = A | B;            // OR
        4'b0110: result[7:0] = ~A;               // NOT
        4'b0111: result[7:0] = ~(A & B);         // NAND
        4'b1000: result[7:0] = ~(A | B);         // NOR
        4'b1001: result[7:0] = A ^ B;            // XOR
        4'b1010: result[7:0] = ~(A ^ B);         // XNOR

        default: result = 0;
    endcase

    zero = (result == 0);

    overflow = (opcode == 4'b0000) ? 
               ((A[7] & B[7] & ~result[7]) | (~A[7] & ~B[7] & result[7])) :
               (opcode == 4'b0001) ? 
               ((A[7] & ~B[7] & ~result[7]) | (~A[7] & B[7] & result[7])) :
               0;
end

endmodule
