module clk_sel(clk_lf,level,btnC,clk_game);
input clk_lf,btnC;
input [1:0]level;
output reg clk_game;
reg [3:0] Fout;
always @ (posedge clk_lf or posedge btnC)
begin 
    if(btnC==1)
        begin
        Fout<=0;
        clk_game<=0;
    end
        else 
        begin
    Fout<=Fout+1;
    case (level)
    2'b00: clk_game <= Fout[3];         
    2'b01: clk_game <= Fout[2];
    2'b10: clk_game <= Fout[1];
    2'b11: clk_game <= Fout[0];         
    endcase
   end
end


endmodule
