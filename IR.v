module IR
  #( parameter DATA_WIDTH = 8)
  (
    input wire sclr,
    input wire clk,
    input wire ena,
	 input wire rst,
    input wire [DATA_WIDTH-1:0] busC,
	 output wire [4:0] opcode
  );
wire [DATA_WIDTH-1:0] Temp;
wire [DATA_WIDTH-1:0] Holder;
assign Temp = sclr ? 8'b00000000 : busC;
 reg_DFF dff_inst
      (.d(Temp),
       .clk(clk),
       .en(ena),
       .rst(rst),
       .q(Holder)
        );
assign opcode = Holder[7:3];
endmodule