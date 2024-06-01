`timescale 1ns / 10ps

module Memory_System_tb;

  // Parámetros
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 3;

  // Señales de prueba
  reg clk;
  reg rst;
  reg INT;
  wire [DATA_WIDTH-1:0] busC;

  // Instancia del módulo de nivel superior
  Memory_System #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) dut (
    .clk(clk),
    .rst(rst),
    .INT(INT),
    .busC(busC)
  );

  // Generación de reloj
  always #5 clk = ~clk;

  // Estímulo
  initial begin
    // Inicialización de la generación de formas de onda
    $dumpfile("Memory_System_tb.vcd");
    $dumpvars(0, Memory_System_tb);

    // Inicialización de señales
    clk = 0;
    rst = 1;
    INT = 0;
    #20 rst = 0;

    // Cargar memoria
    $readmemh("C:/Users/57313/Downloads/Register_Bank.hex", dut.RegisterBank_inst.array_reg);
    $readmemh("C:/Users/57313/Downloads/MAR.hex", dut.RAM_inst.ram);

    // Finalizar la simulación
    #1250 $finish;
  end

endmodule