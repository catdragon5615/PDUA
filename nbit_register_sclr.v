module nbit_register_sclr
#(
    parameter MAX_WIDTH = 4
)
(
    input wire clk,
    input wire rst,
    input wire ena,
    input wire sclr,
    input wire [MAX_WIDTH-1:0] d,
    output reg [MAX_WIDTH-1:0] q
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            q <= {MAX_WIDTH{1'b0}};
        end
        else begin
            if (ena) begin
                if (sclr) begin
                    q <= {MAX_WIDTH{1'b0}};
                end
                else begin
                    q <= d;
                end
            end
        end
    end

endmodule