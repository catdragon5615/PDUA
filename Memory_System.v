module Memory_System
  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 3)
  (
    input wire clk,
    input wire rst,
    input wire INT,
    output wire [DATA_WIDTH-1:0] busC
  );

  wire [4:0] Opcode;
  wire [DATA_WIDTH-1:0] ADRESS_BUS;
  wire [DATA_WIDTH-1:0] BUS_DATA_OUT;
  wire [DATA_WIDTH-1:0] BUS_DATA_IN;
  wire [DATA_WIDTH-1:0] BUS_ALU;
  wire [DATA_WIDTH-1:0] BUS_C_HOLDER;
  wire [DATA_WIDTH-1:0] BUS_B;
  wire [DATA_WIDTH-1:0] BUS_A;
  wire C, N, P, Z;
  wire INT_REG;
  wire [20:0] r_data;
  wire enaf;
  wire ir_en;
  wire ir_clr;
  wire mar_en;
  wire wr_rdn;
  wire mdr_alu_n;
  wire mdr_en;
  wire bank_wr_en;
  wire int_clr;
  wire [ADDR_WIDTH-1:0] selop;
  wire [ADDR_WIDTH-1:0] busC_addr;
  wire [ADDR_WIDTH-1:0] busB_addr;
  wire [1:0] shamt;
  
  sp_ram RAM_inst
    (
      .clk(clk),
      .wr_rdn(wr_rdn),
      .addr(ADRESS_BUS),
      .w_data(BUS_DATA_OUT),
      .r_data(BUS_DATA_IN)
    );
  
  MDR MDR_inst
    (
      .mdr_alu_n(mdr_alu_n),
      .clk(clk),
      .mdr_en(mdr_en),
      .rst(rst),
      .data_bus_in(BUS_DATA_IN),
      .busALU(BUS_ALU),
      .data_bus_out(BUS_DATA_OUT),
      .busC(BUS_C_HOLDER)
    );

  reg_DFF MAR_inst
    (
      .clk(clk),
      .rst(rst),
      .en(mar_en),
      .d(BUS_C_HOLDER),
      .q(ADRESS_BUS)
    );
  
  IR IR_inst
    (
      .sclr(ir_clr),
      .clk(clk),
      .ena(ir_en),
      .rst(rst),
      .busC(BUS_C_HOLDER),
      .opcode(Opcode)
    );
    
  RegisterBank RegisterBank_inst
    (
      .clk(clk),
      .wr_en(bank_wr_en),
      .rst(rst),
      .w_addr(busC_addr),
      .r_addr(busB_addr),
      .w_data(BUS_C_HOLDER),
      .B_data(BUS_B),
      .A_data(BUS_A)
    );
  
  alu Alu_ins
    (
      .clk(clk),
      .rst(rst),
      .busA(BUS_A),
      .busB(BUS_B),
      .selop(selop),
      .shamt(shamt),
      .enaf(enaf),
      .busC(BUS_ALU),
      .C(C),
      .N(N),
      .P(P),
      .Z(Z)
    );

  nbit_register_sclr #(1) INT_REGISTER
    (
      .d(1),
      .clk(clk),
      .ena(INT),
      .sclr(int_clr),
      .rst(rst),
      .q(INT_REG)
    );

  Control_Unit Control_Unit_Inst
    (
      .clk(clk),
      .rst(rst),
      .C(C),
      .INT(INT_REG),
      .N(N),
      .P(P),
      .Z(Z),
      .OPCODE(Opcode),
      .r_data(r_data)
    );

  assign enaf  = r_data[20];
  assign selop = r_data[19:17];
  assign shamt = r_data[16:15];
  assign busB_addr = r_data[14:12];
  assign busC_addr = r_data[11:9];
  assign bank_wr_en = r_data[8];
  assign mar_en = r_data[7];
  assign mdr_en = r_data[6];
  assign mdr_alu_n = r_data[5];
  assign int_clr = r_data[4];
  assign wr_rdn = r_data[2];
  assign ir_en = r_data[1];
  assign ir_clr = r_data[0];

  assign busC = BUS_C_HOLDER;
endmodule