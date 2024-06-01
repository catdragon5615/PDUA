module my_dff (
  input wire clk,
  input wire rst,
  input wire ena,
  input wire d,
  output reg q

);

always @(posedge clk, posedge rst) begin

  if (rst) begin
    q <= 1'b0;
  end else if (ena) begin
    q <= d;
  end
end

endmodule 