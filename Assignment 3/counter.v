module up_counter(input clk, reset, output[2:0] counter
    );
reg [2:0] counter_up;

// up counter
always @(posedge clk or posedge reset)
begin
if(reset)
 counter_up <= 3'b000;
else
case (counter_up)
0:
 counter_up <= counter_up + 3'b001;
1:
 counter_up <= counter_up + 3'b001;
2:
 counter_up <= counter_up + 3'b010;
4:
 counter_up <= counter_up + 3'b010;
6:
 counter_up <= 3'b000;
endcase
end 
assign counter = counter_up;
endmodule 




module upcounter_testbench();
reg clk, reset=0;
wire [2:0] counter;

up_counter dut(clk, reset, counter);
initial begin 
clk=0;
reset=0;
forever #5 clk=~clk;
end
initial begin
reset=1;
#40;
reset=0;
end
endmodule 