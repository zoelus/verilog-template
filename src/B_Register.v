module B_register(
  inout [7:0] Bus,
  input clk,
  input clr, // reset
  input BIb, // enable for registers
  input BOb); // enable for the transceiver
  
  reg [7:0] Bus_latch;

  // if clr is pushed restart the values when clk goes to posedge
  // or if BIb is 0, then pass on the value of bus
  always @ (posedge clk) begin
    if (clr) begin
      Bus_latch <= 8'b0;
    end
    else if (~BIb) begin
      Bus_latch <=  Bus;
    end
  end
  
  // if BOb is 0, then pass the value back into the Bus
  // if it isn't then just store the value
  assign Bus = (BOb == 0) ? Bus_latch : 8'bz;
endmodule
