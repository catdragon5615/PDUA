module reg_DFF
  #(parameter MAX_WIDTH = 8)
  ( input wire clk,
    input wire rst,
    input wire en,
    input wire [MAX_WIDTH-1:0] d,
     output wire [MAX_WIDTH-1:0] q);

  genvar i;
  generate
    for (i = 0; i < MAX_WIDTH; i=i+1) begin : DFF_gen
      dff_sena dff_inst
      (.d(d[i]),
       .clk(clk),
       .en(en),
       .rst(rst),
       .q(q[i])
        );
    end
  endgenerate
  
endmodule