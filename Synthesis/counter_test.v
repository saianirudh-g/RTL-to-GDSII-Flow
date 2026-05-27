module up_down_counter;
parameter N = 4;
reg clk, rst, up_down;
wire [3:0] count;

up_down_counter(clk, rst, up_down, count);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    up_down = 1;
    #10;
    rst = 0;
    #80;
    up_down = 0;
    #80;
    $finish;
end
endmodule
