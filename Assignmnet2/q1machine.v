module mealy111(clk,rst,x_inp,y_out);                                                           // Module fpr  Question1
input clk,rst,x_inp;                                                                            // Declaring input variables
output y_out;                                                                                   // Declaring output variables
reg y_out;                                                                                      // Declaring reg variables
reg [2:0]state;                                                                                 // Declaring reg bus
parameter S0 =0,S1 = 1,S2 = 2,S3 = 3;                                                           // Decclaring four parameters
always@(posedge clk or posedge rst)                                                             // Start of 'always' block
begin
if (rst)                                                                                        // Condition for reset state
begin 
state = S0;
y_out = 0;
end
else 
case (state)                                                                                    // Start of 'case' block
S0:if (x_inp)                                                                                   // Code for determinig different states
begin
state  = S1;                
y_out = 0;
end
else 
begin
state = S0;
y_out = 0; 
end
S1:if (x_inp)
begin
state = S2;
y_out = 0;
end
else 
begin
state = S0;
y_out = 0; 
end
S2:if (x_inp)
begin
state  = S3;
y_out  = 1;
end
else 
begin
state = S0;
y_out = 0; 
end
S3:if (x_inp)
begin
state = S1;
y_out = 0;
end
else 
begin
state = S0;
y_out = 0; 
end 
endcase                                                                                          // End of 'case' block
end                                                                                              // End of 'always' block
endmodule                                                                                        // End of module





module q1_test_bench;                                                                              // Start of test bench
reg clk_t=0,rst_t=1,x_inp_t=0;                                                                   // Declaring the reg variables
wire y_out_t;                                          
mealy111 tb(clk_t,rst_t,x_inp_t,y_out_t);                                                        // Connecting theabove module to the test bench
always #5 clk_t=~clk_t;                                                                          // For alternates in clock
initial 
begin
$display("time = %g\t,x_inp =%b,y_out=%b,clk_t=%b,rst_t=%b",$time,x_inp_t,y_out_t,rst_t,clk_t);
clk_t = 0;
#5 rst_t = 0;                                                                                    // for input 0111011111100111111111
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =0;
#10 x_inp_t =0;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#10 x_inp_t =1;
#200 $stop;                                                                                      // code runs for 200ns
end 
endmodule                                                                                        // End of test bench