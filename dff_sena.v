module dff_sena (
     input wire d,
     input wire clk,
     input wire en,
     input wire rst,
     output  reg q
    );

     always @(posedge clk,  posedge rst) begin
        if (rst)
            q <= 1'b0;
        else if(en)
             q <= d;

    end

endmodule