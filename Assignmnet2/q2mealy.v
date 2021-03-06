
module q2mealy01(clk,rst,x_inp,y_out,state0,state1,state2);                                                     // module for mealy machine for Question 2
input clk,rst,x_inp;                                                                       // Declaring input variables
output y_out,state0,state1,state2;                                                                              // Declaring output variables
reg y_out,state0,state1,state2;                                                                                 // Declaring reg variables
reg [2:0]state;                                                                            // Declaring reg bus
parameter S0 =0, S1 = 1, S2 = 2;                                                           // Decclaring four parameters
always@(posedge clk or posedge rst)                                                        // Starting of 'always' block
begin
if (rst)                                                                                   // code for reset state
begin 
state = S0;
state0 = 1;
state1=0;
state2=0;
y_out = 0;
end
else 
// For the snail to cover 01 and give output 1 after crossing 01, we will define three states S0(Reset), S1(First 0 appeared), S2(when 1 after 0), 
case (state)                                                                               // 'Case' module starts code for different states
S0:if (x_inp==0)                                                                           // Code for different states
begin
state  <= S1;
state0 <= 0;
state1 <= 1;
y_out <= 0;
end
else 
begin
state <= S0;
state0 <= 1;
y_out <= 0; 
end
S1:if (x_inp)
begin
state <= S2;
state2 <= 1;
state1 <= 0;
y_out <= 0;
end
else 
begin
state <= S1;
state1 <= 1;
y_out <= 0; 
end
S2:if (x_inp)
begin
state  <= S0;
state0 <= 1;
state2 <= 0;
y_out <= 1;
end
else 
begin
state <= S1;
state2 <= 0;
state1 <= 1;
y_out <= 1; 
end
default :                                                                                     // Default case
begin
state <= S0;
state0 <= 1;
state1 <= 0;
state2 <= 0;
y_out <= 0;
end
endcase                                                                                       // End of 'case' block
end
endmodule                                                                                     // End of module






module q2_mealy_testb;                                                                           // Starting of test bench 
reg clk_t=1,rst_t=1,x_inp_t=0;                                                                // Declaring reg variables
wire y_out_t,state0_t,state1_t,state2_t;                                                                                 // Declaring wire
q2mealy01 q2b(clk_t,rst_t,x_inp_t,y_out_t,state0_t,state1_t,state2_t);                                                   // Connecting the above module to the test bench
always #5 clk_t=~clk_t;
initial 
begin
$display("time = %g\t,x_inp =%b,y_out=%b,clk_t=%b,rst_t=%b,state0_t=%b,state1_t=%b,state2_t=%b",$time,x_inp_t,y_out_t,rst_t,clk_t,state0_t,state1_t,state2_t);
#10 rst_t = 0;
#10 x_inp_t =0;                                                                               // For input 0100110111
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#100 $stop;                                                                                   // The code will run for 100ns
end
endmodule                                                                                     // End of test bench  