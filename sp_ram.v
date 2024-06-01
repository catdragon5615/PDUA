module sp_ram
  #(parameter DATA_WIDTH = 8,
              ADDR_WIDTH = 8)
 (  input clk,
    input wr_rdn,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] w_data,
    output [DATA_WIDTH-1:0] r_data
);

//signal declaration
reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
//reg [ADDR_WIDTH-1:0] addr_reg;

//write procedure
always @(posedge clk) begin
    if (wr_rdn) begin
        ram[addr] <= w_data;
    end
 //   addr_reg <= addr;
end

//READ
//assign r_data = ram[addr_reg];
assign r_data = ram[addr];

endmodule