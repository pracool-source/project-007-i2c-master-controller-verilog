`timescale 1ns/1ps

module i2c_master_tb;

reg clk;
reg reset;
reg start;
reg [7:0] data_in;

wire scl;
wire sda;
wire busy;

i2c_master uut(
    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(data_in),
    .scl(scl),
    .sda(sda),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;
    start = 0;

    #10 reset = 0;

    data_in = 8'b11001010;
    start = 1;

    #10 start = 0;

    #250;

    $finish;

end

endmodule
