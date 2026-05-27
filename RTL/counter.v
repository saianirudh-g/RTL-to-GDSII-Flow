module up_down_counter(clk, rst, up_down, count);
input clk, rst, up_down;
output reg [7:0] count;

always @(posedge clk or negedge rst)
begin
    if (!rst)
        count <= 0;
    else begin
        if (up_down)
            count <= count + 1;
        else
            count <= count - 1;
    end
end
endmodule
