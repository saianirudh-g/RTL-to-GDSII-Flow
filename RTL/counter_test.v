module counter_test;
reg clk, rst, up_down;
wire [7:0] count;

initial begin
    clk = 0;
    rst = 0;
    up_down = 1;
    #10;
    rst = 1;
    #100;
    up_down = 0;
    #200;
    up_down = 1;
end

up_down_counter counter1(clk, rst, up_down, count);
always #5 clk = ~clk;
endmodule
