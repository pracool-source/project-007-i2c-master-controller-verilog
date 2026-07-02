module i2c_master(
    input clk,
    input reset,
    input start,
    input [7:0] data_in,
    output reg scl,
    output reg sda,
    output reg busy
);

reg [7:0] shift_reg;
reg [3:0] bit_count;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        scl <= 1;
        sda <= 1;
        busy <= 0;
        bit_count <= 0;
    end

    else if(start && !busy)
    begin
        busy <= 1;
        shift_reg <= data_in;
        bit_count <= 8;
    end

    else if(busy)
    begin
        scl <= ~scl;

        if(!scl)
        begin
            sda <= shift_reg[7];
            shift_reg <= shift_reg << 1;
            bit_count <= bit_count - 1;

            if(bit_count == 1)
            begin
                busy <= 0;
                scl <= 1;
                sda <= 1;
            end
        end
    end
end

endmodule
