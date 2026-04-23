module alu_control(
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,
    output reg [3:0] alu_ctrl
    );
    always @(*) begin
    case (opcode)

        7'b0110011: begin
            case ({funct7, funct3})
                {7'b0000000,3'b000}: alu_ctrl = 4'b0000; // ADD
                {7'b0100000,3'b000}: alu_ctrl = 4'b0001; // SUB
                {7'b0000000,3'b001}: alu_ctrl = 4'b0010; // SLL
                {7'b0000000,3'b101}: alu_ctrl = 4'b0011; // SRL
                default: alu_ctrl = 4'b1111;
            endcase
        end

        7'b0010011: alu_ctrl = 4'b0000; // ADDI
        7'b1100011: alu_ctrl = 4'b0001; // BEQ

        default: alu_ctrl = 4'b1111;
    endcase
end

endmodule
