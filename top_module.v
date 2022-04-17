module topmodule (clk, sw0, sw15, btnU, btnC, btnD, an, seg, dp, led);

input btnC, btnU, btnD;
input clk;
input sw0, sw15;
output [6:0] seg;
output [3:0] an;
output dp;
output [15:0] led;
wire up, down;
wire [1:0] level; 
wire clk_lf,clk_BTN; 
wire clk_game; 
wire [3:0] score_P1; 
wire [3:0] score_P2;

updown_counter u3(up,down,btnC,level);
clk_divider u4(clk,btnC,clk_lf); // Obtaining 10Hz clk from 100MHz main oscillator
clk_sel u5(clk_lf,level,btnC,clk_game); // game-level selection
lamp_handball u6(clk,clk_game,btnC,sw15,sw0,led,score_P1,score_P2);
clk_divider u10(clk_lf,btnC,clk_BTN);                                


endmodule
