module MDR
  #( parameter DATA_WIDTH = 8)
  (
    input wire mdr_alu_n,
    input wire clk,
    input wire mdr_en,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_bus_in,
    input wire [DATA_WIDTH-1:0] busALU,
    output wire [DATA_WIDTH-1:0] data_bus_out,
    output wire [DATA_WIDTH-1:0] busC
  );

  reg [DATA_WIDTH-1:0] array_reg [1:0];

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      array_reg[0] <= 8'b00000000;  
      array_reg[1] <= 8'b00000000; 
    end else if (mdr_en) begin 
      array_reg[0] <= busALU;
      array_reg[1] <= data_bus_in;
    end
  end
  
  assign busC = mdr_alu_n ? array_reg[1] : busALU;
  assign data_bus_out = array_reg[0];
endmodule