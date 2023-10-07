/*
  32-bit ALU

  Barrel Shifter:
  00 - No shift
  01 - Logical left
  10 - Logical right
  11 - Arithmetic right

  LookAheadCarry Adder:
  00 -> Add
  11 -> Subtract

  Logic Unit:
  00 - AND
  01 - OR
  10 - XOR
  11 - NOR

  Function Class:
  00 - Shift
  01 - Set less
  10 - Arithmetic 
  11 - Logic

  Flags:
  - Overflow
  - Zero
*/

module ALU #(parameter N = 32)
(
  input [N-1:0] a, b,
  input [1:0] opcode, fnClass,
  output zerof, ovf, c_out,
  output [N-1:0] out
);

  parameter B = $clog2(N);

  wire [N-1:0] b1;
  wire [N-1:0] add_sub;
  wire [N-1:0] shift;
  wire [N-1:0] logic_o;

  assign c_in = (opcode == 2'b11) ? 1'b1 : 0;   // If Add
  assign b1 = (opcode == 2'b11) ? (~b + 1) : b;

  // Instances
  logic_unit LOGIC_M (.a(a), .b(b), .opcode(opcode), .out(logic_o));
  barrelShifter SHIFTER_M (.number_i(a), .shift_amount_i(b[B-1:0]), .operation_i(opcode), .shift_number_o(shift));
  lookAheadCarryAdder ADDER_M (.a(a), .b(b1), .c_in(1'b0), .c_out(c_out), .sum(add_sub));

  assign out = (fnClass == 0) ? shift :
               (fnClass == 1) ? 'bz   :
               (fnClass == 2) ? add_sub :
                               logic_o;

  assign zerof = ~|out;
  assign ovf = (a == b) ? ((a != out[N-1:0]) ? 1 : 0) : 1'b0;

endmodule
