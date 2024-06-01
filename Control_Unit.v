module Control_Unit
#(
  parameter OPCODE_MAX_WIDTH = 5,
  parameter uPC_MAX_WIDTH = 3
)
(
  input wire clk,
  input wire rst,
  input wire C,
  input wire INT,
  input wire N,
  input wire P,
  input wire Z,
  input wire [OPCODE_MAX_WIDTH-1:0] OPCODE,
  output wire [20:0] r_data
);
  
  wire [28:0] r_data_holder;
  wire [uPC_MAX_WIDTH-1:0] uPC;
  wire [uPC_MAX_WIDTH-1:0] d;
  wire load;
  wire [uPC_MAX_WIDTH-1:0] uPC_result;
  wire [7:0] addr;
  wire [2:0] jcond;
  wire [2:0] offset;
  wire clr_uPc;
  wire en_uPc;
  assign addr = {OPCODE,uPC};
  
  assign load = (jcond == 3'b000) ? 1'b0 :
                (jcond == 3'b001) ? 1'b1 : 
                (jcond == 3'b010) ? Z    : 
                (jcond == 3'b011) ? N    : 
                (jcond == 3'b100) ? C    : 
                (jcond == 3'b101) ? P    : 
                (jcond == 3'b110) ? INT  : 
                (jcond == 3'b111) ? 1'b0 : 1'b0;
					 
	assign d = load ? offset: uPC_result;		
	
	add_sub #(uPC_MAX_WIDTH) add_uPC (
    .a(uPC),
    .b(3'b001),
    .addn_sub(0),
    .s(uPC_result)
  );	
  
  nbit_register_sclr #(uPC_MAX_WIDTH) uPC_Reg(
    .clk(clk),
    .rst(rst),
    .ena(en_uPc),
    .sclr(clr_uPc),
    .d(d),
    .q(uPC)
  );
	 
  uP_ROM up_ROM_Inst (
    .addr(addr),
    .r_data(r_data_holder)
  );
  
assign offset  = r_data_holder[2:0];
assign jcond   = r_data_holder[5:3];
assign clr_uPc = r_data_holder[6];
assign en_uPc  = r_data_holder[7];
assign r_data = r_data_holder[28:8];
endmodule