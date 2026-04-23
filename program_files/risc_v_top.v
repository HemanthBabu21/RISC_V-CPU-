module risc_v_top(
    input clk,
    input rst
);

// Internal wires
wire [31:0] pc, next_pc, instr;
wire [31:0] read_data1, read_data2, imm;
wire [31:0] alu_in2, alu_result;
wire [3:0] alu_ctrl;
wire reg_write, alu_src, branch;
wire zero;
wire pc_src;

// Program Counter
pc pc0 (
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc(pc)
);

// Instruction Memory
instr_mem imem (
    .addr(pc),
    .instr(instr)
);

// Register File
reg_file rf (
    .clk(clk),
    .rs1(instr[19:15]),
    .rs2(instr[24:20]),
    .rd(instr[11:7]),
    .write_data(alu_result),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Immediate Generator
imm_gen ig (
    .instr(instr),
    .imm(imm)
);

// ALU input mux
assign alu_in2 = (alu_src) ? imm : read_data2;

// ALU Control
alu_control ac (
    .funct7(instr[31:25]),
    .funct3(instr[14:12]),
    .opcode(instr[6:0]),
    .alu_ctrl(alu_ctrl)
);

// ALU
alu alu0 (
    .a(read_data1),
    .b(alu_in2),
    .alu_ctrl(alu_ctrl),
    .result(alu_result),
    .zero(zero)
);

// Control Unit
control_unit cu (
    .opcode(instr[6:0]),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .branch(branch)
);

// Branch decision
assign pc_src = branch & zero;

// Next PC logic
assign next_pc = pc_src ? pc + imm : pc + 4;

endmodule
