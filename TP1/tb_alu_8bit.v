`timescale 1ns / 1ps
`include "alu8bits.v"

module tb_alu_8bit;
  reg [7:0] a, b;
  reg [2:0] opcode;
  wire [7:0] result;
  wire [3:0] flags;


  alu8bit uut(a, b, opcode, result, flags);

  initial begin
    $dumpfile("alu_8bit.vcd");
    $dumpvars(0, tb_alu_8bit);

    a = 8'b0; // Inicialización de entradas
    b = 8'b0;
    opcode = 3'b0;
    #10;

    // Casos de prueba básicos
    a = 8'h01; b = 8'h01;
    opcode = 3'b000; #10; // suma
    opcode = 3'b001; #10; // resta
    opcode = 3'b010; #10; // AND
    opcode = 3'b011; #10; // OR
    opcode = 3'b100; #10; // XOR
    opcode = 3'b101; #10; // comparación


    // Casos de prueba para testeo de flags
    
    a = 8'b00000001; b = 8'b00000001; opcode = 3'b001; #10; 
    // resta que da cero, flag zero
    a = 8'b10000000; b = 8'b00000001; opcode = 3'b000; #10;
    // suma que da overflow, flag overflow
    a = 8'b11111111; b = 8'b00000001; opcode = 3'b000; #10; 
    // suma que da carry, flag carry 

    $finish;
  end
endmodule
