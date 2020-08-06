`include "ASSIGNMENT4.v"
module test();
  reg reset, clk, Ta, Tb;
  wire [1:0] La, Lb;
  tlc DUT(reset, clk, Ta, Tb, La, Lb);
  initial
    begin
      clk = 1'b0;
      forever #5 clk = ~clk;
    end
    initial 
      begin
        $dumpfile("ASSIGNMENT4.vcd");
        $dumpvars(1,test);
        reset = 1'b1;
        #20 reset = 1'b0; Ta = 1'b0; Tb = 1'b0;
        #20 Ta = 1'b0; Tb = 1'b0;
        #20 Ta = 1'b1; Tb = 1'b0;
        #20 Ta = 1'b0; Tb = 1'b1;
        #20 Ta = 1'b1; Tb = 1'b1;
        #20;
        $finish;
      end

endmodule