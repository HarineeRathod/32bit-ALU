module ALU_TB;

  // Parameters
  parameter N = 32;

  // Signals
  reg [N-1:0] a, b;
  reg [1:0] opcode, fnClass;
  wire zerof, ovf, c_out;
  wire [N-1:0] out;

  // Instantiate ALU
  ALU #(N) dut (
    .a(a),
    .b(b),
    .opcode(opcode),
    .fnClass(fnClass),
    .zerof(zerof),
    .ovf(ovf),
    .c_out(c_out),
    .out(out)
  );

  // Initialize signals
  initial begin
    // Stimulus generation
    // You can create test cases here
    // Set inputs and control signals to test different operations
    
    // Example test case 1: Addition
    a = 32'h00000003;
    b = 32'h00000002;
    opcode = 2'b00; // Add
    fnClass = 2'b10; // Arithmetic
    #10; // Wait for some time
    $display("a = %h, b = %h, opcode = %b, fnClass = %b, out = %b, zerof = %b, ovf = %b, c_out = %b", a, b, opcode, fnClass, out, zerof, ovf, c_out);
    
    // Example test case 2: Subtraction
    a = 32'h00000005;
    b = 32'h00000002;
    opcode = 2'b11; // Subtract
    fnClass = 2'b10; // Arithmetic
    #10; // Wait for some time
    $display("a = %h, b = %h, opcode = %b, fnClass = %b, out = %b, zerof = %b, ovf = %b, c_out = %b", a, b, opcode, fnClass, out, zerof, ovf, c_out);
    
    // Example test case 3: Logical AND
    a = 32'h00000005;
    b = 32'h00000003;
    opcode = 2'b00; // Logical AND
    fnClass = 2'b11; // Logic
    #10; // Wait for some time
    $display("a = %h, b = %h, opcode = %b, fnClass = %b, out = %b, zerof = %b, ovf = %b, c_out = %b", a, b, opcode, fnClass, out, zerof, ovf, c_out);

    opcode = 2'b01; //  Left shift
    fnClass = 2'b00; // Shift
    #10;
    $display("a = %h, b = %h, opcode = %b, fnClass = %b, out = %b, zerof = %b, ovf = %b, c_out = %b", a, b, opcode, fnClass, out, zerof, ovf, c_out);
    
    $finish;
  end

endmodule
