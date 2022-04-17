
module updown_counter(up,down,btnC,level);
input up,down,btnC;
output reg [1:0]level;
reg emptybit; 

  always@(posedge up or posedge down or posedge btnC )
    begin 
    if(btnC)
    level<=2'b00;

     else if(up)
    level<=level+2'b01;
    
    else if(down)
   level<=level-2'b01;
  
   
    
        end 

endmodule
