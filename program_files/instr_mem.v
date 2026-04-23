module instr_mem(
    output [31:0] instr,
    input [31:0] addr
    );
    reg [31:0] memory [0:255];

initial begin
    memory[0] = 32'h00A00093; // ADDI x1, x0, 10
    memory[1] = 32'h00500113; // ADDI x2, x0, 5
    memory[2] = 32'h002081B3; // ADD x3, x1, x2
    memory[3] = 32'h40208233; // SUB x4, x1, x2
    memory[4] = 32'h002092B3; // SLL x5, x1, x2
    memory[5] = 32'h0020D333; // SRL x6, x1, x2
    memory[6] = 32'h00208663; // BEQ x1, x2, +8
end

assign instr = memory[addr[9:2]];
endmodule
