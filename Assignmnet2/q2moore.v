module moore01(x_in,y_out,clk,rst,state0,state1,state2);                                                  // Module for moore machine of Question 2
input x_in,clk,rst;                                                                  // Declaring input variables
output y_out,state0,state1,state2;                                                                        // Declaring output variables
reg [1:0] state,nxtstate;                                                            // Declaring reg variables
parameter S0=1,S1=2,S2=3;                                                            // Declaring three parameters
always@(posedge rst,posedge clk)                                                     // Starting of 'always' block
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
assign y_out = (state==S2);                                                           // Assigning value to output
assign state0 = (state==S0);
assign state1 = (state==S1);
assign state2 = (state==S2);
endmodule                                                                             // End of module





module q2_moore_test_b;                                                                   // Starting of test bench 
reg clk1=1,rst1=1,x_inp1=0;                                                           // Declaring reg variables
wire y_out1,state01,state11,state21;                                                                          // Declaring wire
moore01 q2a(x_inp1,y_out1,clk1,rst1,state01,state11,state21);                                                 // Connecting the above module with the test bench                           
always #5 clk1 = ~clk1;
initial
begin
$display("time =%g\t ,x_inp1=%b, rst1=%b, y_out1=%b,clk1=%b,state01=%b,state11=%b,state21=%b", $time, x_inp1, rst1, y_out1,clk1,state01,state11,state21);
#10 rst1=0;
#10 x_inp1=0;                                                                          // For input  0100110111
#10 x_inp1=1;
#10 x_inp1=0;  
#10 x_inp1=0;
#10 x_inp1=1;
#10 x_inp1=1;
#10 x_inp1=0;  
#10 x_inp1=1;
#10 x_inp1=1;
#10 x_inp1=1; 
#100 $stop;                                                                            // The code will run for 100ns
end                        
endmodule                                                                              // End of test bench
