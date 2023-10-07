// shifter
module barrelShifter #(
    parameter N = 32,
    parameter B = $clog2(N)
) (
    input [N-1:0] number_i,
    input [B-1:0] shift_amount_i,
    input [  1:0] operation_i,
    //input en_i,

    output [N-1:0] shift_number_o
);

parameter LEFT = 2'b01, RIGHT = 2'b10, ARIGHT = 2'b11;

reg [N-1:0] shift_reg;

always @(*) begin
   // if (en_i) begin
        shift_reg = number_i;
        case (operation_i)
        LEFT:begin
            if(shift_amount_i[4])
                shift_reg = {shift_reg[15:0],{16{1'b0}}};

            if(shift_amount_i[3])
                shift_reg = {shift_reg[23:0],{8{1'b0}}};

            if(shift_amount_i[2])
                shift_reg = {shift_reg[27:0],{4{1'b0}}};

            if(shift_amount_i[1])
                shift_reg = {shift_reg[29:0],{2{1'b0}}};

            if(shift_amount_i[0])
                shift_reg = {shift_reg[30:0],{1{1'b0}}};

        end
        RIGHT:begin
            if(shift_amount_i[4])
                shift_reg = {{16{1'b0}}, shift_reg[31:16]};

            if(shift_amount_i[3])
                shift_reg = {{8{1'b0}}, shift_reg[31:8]};
            
            if(shift_amount_i[2])
                shift_reg = {{4{1'b0}}, shift_reg[31:4]};
            
            if(shift_amount_i[1])
                shift_reg = {{2{1'b0}}, shift_reg[31:2]};

            if(shift_amount_i[0])
                shift_reg = {{1{1'b0}}, shift_reg[31:1]};
        end
        ARIGHT:begin
            if(shift_amount_i[4])
                shift_reg = {{16{shift_reg[31]}}, shift_reg[31:16]};

            if(shift_amount_i[3])
                shift_reg = {{8{shift_reg[31]}}, shift_reg[31:8]};
            
            if(shift_amount_i[2])
                shift_reg = {{4{shift_reg[31]}}, shift_reg[31:4]};
            
            if(shift_amount_i[1])
                shift_reg = {{2{shift_reg[31]}}, shift_reg[31:2]};

            if(shift_amount_i[0])
                shift_reg = {{1{shift_reg[31]}}, shift_reg[31:1]};
        end
        default: shift_reg = number_i;
        endcase 
    //end
end

assign shift_number_o = shift_reg;
    
endmodule

