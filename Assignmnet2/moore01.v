
module moore01(x_in,y_out,clk,rst);
input x_in,clk,rst;
output y_out;

reg [1:0] state,nxtstate;
parameter S0=1,S1=2,S2=3;

always@(posedge rst,posedge clk)
if (rst) state <= S0;
else state <= nxtstate;


always@(*)
case (state)
S0: 
	if (x_in) nxtstate <=S0;
	else nxtstate <= S1;
S1:
	if (x_in) nxtstate <= S2;
	else nxtstate <= S1;
S2:
	if (x_in) nxtstate <= S0;
	else nxtstate <= S1;
default: nxtstate <= S0;
endcase 
assign y_out = (state==S2);  

endmodule 





module test_b;
reg clk1=0,rst1=1,x_inp1=0;
wire y_out1;
moore01 bc(x_inp1,y_out1,clk1,rst1);
//initial #200 $finish;
always #5 clk1 = ~clk1;
initial
	   begin
	     $display("time =%g\t ,x_inp1=%b, rst1=%b, y_out1=%b,clk1=%b", $time, x_inp1, rst1, y_out1,clk1);
	     #10 rst1=0;
	     #10 x_inp1=1;
	     #10 x_inp1=1;
	     #10 x_inp1=0;  // pattern 1
	     #10 x_inp1=1;
	     #10 x_inp1=1;
	     #10 x_inp1=1;
	     #10 x_inp1=0;  // pattern 2
	     #10 x_inp1=0;
	     #10 x_inp1=1;
	     #10 x_inp1=0;
	     #10 x_inp1=1;
	     #10 x_inp1=1;
	     #10 x_inp1=0; 
	     #180 $stop;
	   end
endmodule
