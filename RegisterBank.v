module RegisterBank #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 3
)(
  input wire clk,
  input wire wr_en,
  input wire rst, 
  input wire [ADDR_WIDTH-1:0] w_addr, r_addr,
  input wire [DATA_WIDTH-1:0] w_data,
  output wire [DATA_WIDTH-1:0] B_data,
  output wire [DATA_WIDTH-1:0] A_data
);

  // Signal declaration
  reg [DATA_WIDTH-1:0] array_reg [2**ADDR_WIDTH-1:0];
  

  // Write procedure
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      array_reg[0] <= 8'b00000000; // PC_INIT
      array_reg[1] <= 8'b00000000; // SP_INIT
      array_reg[2] <= 8'b00000000; // DPTR_INIT
      array_reg[3] <= 8'b00000000; // regA_INIT
      array_reg[4] <= 8'b00000000; // IVP_INIT
		array_reg[5] <= 8'b00000000; 
      array_reg[6] <= 8'b00000000; 
      array_reg[7] <= 8'b00000000; // ACC_INIT
    end else if (wr_en) begin 
      array_reg[w_addr] <= w_data;
    end
  end

  // READ
  assign B_data = array_reg[r_addr];
  assign A_data = array_reg[7];

endmodule