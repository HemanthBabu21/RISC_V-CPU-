module tb();
reg clk;
reg rst;

// Instantiate DUT (Device Under Test)
risc_v_top uut (
    .clk(clk),
    .rst(rst)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    // Apply reset
    #10;
    rst = 0;

    // Run simulation
    #300 $finish;
end

// Monitor values
initial begin
    $monitor("T=%0t | PC=%h | x1=%d x2=%d x3=%d x4=%d",
              $time,
              uut.pc,
              uut.rf.regs[1],
              uut.rf.regs[2],
              uut.rf.regs[3],
              uut.rf.regs[4]);
end

endmodule
