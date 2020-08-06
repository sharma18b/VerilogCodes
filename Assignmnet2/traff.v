module traffic_light(La, Lb, Ta, Tb , clk, rst);
parameter RoadAGreen_RoadBRed=2'b00, // RoadA green and RoadB red
   RoadAYellow_RoadBRed = 2'b01,// RoadA yellow and RoadB red
   RoadARed_RoadBGreen=2'b10,// RoadA red and RoadB green
   RoadARed_RoadBYellow=2'b11;// RoadA red and RoadB yellow
input Ta,Tb, // sensor
   clk, // clock = 50 MHz
   rst; // reset active low
output reg[2:0] La;
output reg[2:0] Lb; // output of lights
// fpga4student.com FPGA projects, VHDL projects, Verilog projects
reg[27:0] count=0,count_delay=0;
reg delay10s1=0,delay10s2=0, delay3s1=0,delay3s2=0,RED_count_en=0,YELLOW_count_en1=0,YELLOW_count_en2=0;
wire clk_enable; // clock enable signal for1s
reg[1:0] state, next_state;
// next state
always @(posedge clk or negedge rst)
begin
if(~rst)
 state <= 2'b00;
else 
 state <= next_state; 
end
// FSM
always @(*)
begin
case(state)
RoadAGreen_RoadBRed : begin // Green on RoadA and red on RoadB way
 RED_count_en=0;
 YELLOW_count_en1=0;
 YELLOW_count_en2=0;
 La = 3'b001;
 Lb = 3'b100;
 if(Tb) next_state = RoadAYellow_RoadBRed; 
 // if sensor detects vehicles on RoadB road, 
 // turn RoadA to yellow -> green
 else next_state = RoadAGreen_RoadBRed;
end
RoadAYellow_RoadBRed: begin// yellow on RoadA and red on RoadB way
  La = 3'b010;
  Lb = 3'b100;
  RED_count_en=0;
 YELLOW_count_en1=1;
 YELLOW_count_en2=0;
  if(delay3s1 ) next_state = RoadARed_RoadBGreen;
  // yellow for 3s, then red
  else next_state = RoadAYellow_RoadBRed;
end
RoadARed_RoadBGreen: begin// red on RoadA and green on RoadB way
 La = 3'b100;
 Lb = 3'b001;
 RED_count_en=0;
 YELLOW_count_en1=0;
 YELLOW_count_en2=0;
 if(Ta==1) next_state = RoadARed_RoadBYellow;
 // red in 10s then turn to yellow -> green again for RoadA
 else next_state = RoadARed_RoadBGreen;
end
RoadARed_RoadBYellow:begin// red on RoadA and yellow on RoadB way
 La = 3'b100;
 Lb = 3'b010;
 RED_count_en=0;
 YELLOW_count_en1=0;
 YELLOW_count_en2=1;
 if(delay3s2) next_state = RoadAGreen_RoadBRed;
 // turn green for RoadA, red for RoadB road
 else next_state = RoadARed_RoadBYellow;
end
default: next_state = RoadAGreen_RoadBRed;
endcase
end
// fpga4student.com FPGA projects, VHDL projects, Verilog projects
// create red and yellow delay counts
always @(posedge clk)
begin
if(clk_enable==1) begin
 if(RED_count_en||YELLOW_count_en1||YELLOW_count_en2)
  count_delay <=count_delay + 1;
  if((count_delay == 9)&&RED_count_en) 
  begin
  // delay10s1=1;
   //delay10s2=1;
   delay3s1=0;
   delay3s2=0;
   count_delay<=0;
  end
  else if((count_delay == 2)&&YELLOW_count_en1) 
  begin
  // delay10s1=0;
  // delay10s2=0;
   delay3s1=1;
   delay3s2=0;
   count_delay<=0;
  end
  else if((count_delay == 2)&&YELLOW_count_en2) 
  begin
  // delay10s1=0;
  // delay10s2=0;
   delay3s1=0;
   delay3s2=1;
   count_delay<=0;
  end
  else
  begin
   //delay10s1=0;
  // delay10s2=0;
   delay3s1=0;
   delay3s2=0;
  end 
 end
end
// create 1s clock enable 
always @(posedge clk)
begin
 count <=count + 1;
 //if(count == 50000000) // 50,000,000 for 50 MHz clock running on real FPGA
 if(count == 3) // for testbench
  count <= 0;
end
 assign clk_enable = count==3 ? 1: 0; // 50,000,000 for 50MHz running on FPGA
endmodule 







`timescale 10 ns/ 1 ps
// 2. Preprocessor Directives
`define DELAY 1
module tb_traffic_test2;
// 4. Parameter definitions
parameter ENDTIME  = 400000;
// 5. DUT Input regs
//integer count, count1, a;
reg clk;
reg rst_n;
reg sensor1,sensor2;
wire [2:0] light_RoadB;
// 6. DUT Output wires
wire [2:0] light_RoadA;

// fpga4student.com FPGA projects, VHDL projects, Verilog projects
// 7. DUT Instantiation
traffic_light tb(light_RoadA, light_RoadB, sensor1,sensor2, clk, rst_n);

// 8. Initial Conditions
initial
 begin
 clk = 1'b0;
 rst_n = 1'b0;
 sensor1 = 1'b0;
 sensor2 = 1'b0;
 // count = 0;
//// count1=0;
// a=0;
 end
// 9. Generating Test Vectors
initial
 begin
 main;
 end
task main;
 fork
 clock_gen;
 reset_gen;
 operation_flow;
 debug_output;
 endsimulation;
 join
endtask
task clock_gen;
 begin
 forever #`DELAY clk = !clk;
 end
endtask

task reset_gen;
 begin
 rst_n = 0;
 # 20
 rst_n = 1;
 end
endtask

// fpga4student.com FPGA projects, VHDL projects, Verilog projects
task operation_flow;
 begin
 sensor1 = 0;
 sensor2 = 0;
 # 600
 sensor2 = 1;
 sensor1 = 0;
 # 1200
 sensor1 = 1;
 sensor2 = 0;
 # 1200
 sensor1 = 1;
 sensor2 = 1;
 end
endtask
// 10. Debug output
task debug_output;
 begin
 $monitor("TIME = %d, rst_n = %b, sensor1 = %b,,sensor2=%b, light_RoadB = %h, light_RoadA = %h,clk = %b",$time,rst_n ,sensor1,sensor2,light_RoadA,light_RoadB,clk );
 end
endtask


//12. Determines the simulation limit
task endsimulation;
 begin
 #ENDTIME
 $finish;
 end
endtask
    
endmodule




