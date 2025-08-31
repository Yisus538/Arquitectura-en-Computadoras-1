module alu8bit(
  input [7:0] a,
  input [7:0] b,
  input [2:0] opcode,
  output reg [7:0] result,
  output reg [3:0] flags
  // flags[0]: Zero, flags[1]: Carry, flags[2]: Negative, flags[3]: Overflow
);

  reg carry; //bit auxiliar para carry
  reg overflow; //bit auxiliar para overflow

  always @(*) begin
    result = 8'h00;
    carry  = 1'b0;
    overflow = 1'b0;

    case (opcode)
      3'b000: begin //suma
      result = a + b;     
      {carry, result} = a + b; // Captura el carry
      overflow = (a[7] == b[7]) && (result[7])!= a[7]; // ALU detecta overflow
      end

      3'b001: begin //resta 
      overflow = (a[7] == b[7]) && (result[7])!= a[7]; // ALU detecta overflow
      end

      3'b010: result = a & b;         // AND
      3'b011: result = a | b;      // OR
      3'b100: result= a ^ b;        // XOR

      3'b101: result = (a < b) ? 8'b00000001 : 8'b00000000; 
      // Comparación, si a < b, result = 1, else 0
      
      default: result = 4'b0000;      // Valor por defecto

    endcase

       // Asignación de flags
      flags[0] = (result == 8'b0); // Zero flag
      flags[1] = carry; // Carry flag
      flags[2] = result[7]; // Negative flag
      flags[3] = overflow; // Overflow flag

  end


endmodule
