module logic_unit #(parameter N = 32)(
  input [N-1:0] a, b,
  input [1:0] opcode,
  output reg [N-1:0] out
);

always @(*)
begin
  case (opcode[1:0])
    2'b00:
    begin
      out = a & b;
    end

    2'b01:
    begin
      out = a | b;
    end

    2'b10:
    begin
      out = a ^ b;
    end

    2'b11:
    begin
      out = ~(a | b);
    end
  endcase
end

endmodule
