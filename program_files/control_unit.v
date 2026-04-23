module control_unit(
    input [6:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg  branch
    );
    always @(*) begin
    case(opcode)

        7'b0110011: begin // R-type
            reg_write = 1;
            alu_src = 0;
            branch = 0;
        end

        7'b0010011: begin // ADDI
            reg_write = 1;
            alu_src = 1;
            branch = 0;
        end

        7'b1100011: begin // BEQ
            reg_write = 0;
            alu_src = 0;
            branch = 1;
        end

        default: begin
            reg_write = 0;
            alu_src = 0;
            branch = 0;
        end
    endcase
end

endmodule
