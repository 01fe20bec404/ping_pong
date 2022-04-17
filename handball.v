module lamp_handball(clk_lf,clk_game,rst,LeftSw,RightSw,Led,Score_Left,Score_Right );
input clk_game,rst,LeftSw,RightSw,clk_lf;
output   [15:0]Led;
output [3:0] Score_Left,Score_Right;

reg GameDirection;       
reg GameStart;
reg LeftBorder; 
reg RightBorder; 
reg LeftPass;
reg RightPass;
reg Center;
reg [5:0]Counter;
reg [3:0] score_Left,score_Right;
reg [15:0]led;
    

  
  initial 
  begin 
                Counter=17;
                GameStart=0; 
                GameDirection=1;
                score_Right=0;
                score_Left=0;
  end 
//     always @(posedge clk_lf)
//     begin 
//     if(rst==1)
//     begin
//              Counter=17;
//              GameStart=0; 
//              GameDirection=1;
//              score_Right=0;
//              score_Left=0;
//          end
//          end
          
       always @ (posedge clk_game ) // For Real   
    // always @ ( posedge clk_game or  posedge rst)      
begin
    if(rst==1)
    begin
        Counter=17;
        GameStart=0; 
        GameDirection=1;
        score_Right=0;
        score_Left=0;
    end
    if(GameDirection&GameStart)
        Counter=Counter-1;
    if(!GameDirection&GameStart)
       Counter=Counter+1;
       
       if(!GameStart&((score_Left>0)|(score_Right>0)))
       begin 
               Counter =17;
               
       end 
       
    
    if(~GameStart&LeftBorder&LeftSw)             
    begin
        GameStart=1; 
        GameDirection=1;
        Counter =17;
    end
    
    if(RightPass&RightSw)
        GameDirection=0;

    else if(LeftPass&LeftSw)
        GameDirection=1;
    
    else if (RightBorder&GameStart&GameDirection)
    begin
        score_Left=score_Left+1; 
        GameStart=0;
       end   
    else if (LeftBorder&GameStart&!GameDirection)               
    begin
        score_Right=score_Right +1; 
        GameStart=0;
    end
    
    else if (Center&GameStart&RightSw)
    begin
        score_Left=score_Left+1; 
        GameStart=0;
    end
   else if(Center&GameStart&LeftSw)
    begin
        score_Right=score_Right +1; 
        GameStart=0;
     end                                               
   
        
                                   LeftBorder  LeftPass    Center      RightPass   RightBorder
                                      17         16-15   14-------3       2-1          0


    if(Counter==17)  LeftBorder=1;
    else             LeftBorder=0;
    if (Counter==0)  RightBorder=1;
    else             RightBorder=0;
    
    
    if(Counter==16|Counter==15) LeftPass=1;
    else                        LeftPass=0;
    
    if(Counter==2|Counter==1)   RightPass=1;
    else                        RightPass=0;
    
    if(Counter<15&Counter>2)  Center=1;
    else                        Center=0;
    
    if(Counter>17)  Counter=17;
       if(Counter<0)  Counter=17;
                                  
                                  
     case(Counter)
          0:  led=16'b0000000000000001;//'b0001111111111000;
          1:  led=16'b0000000000000001;
          2:  led=16'b0000000000000010;
          3:  led=16'b0000000000000100;
          4:  led=16'b0000000000001000;
          5:  led=16'b0000000000010000;
          6:  led=16'b0000000000100000;
          7:  led=16'b0000000001000000;
          8:  led=16'b0000000010000000;
          9:  led=16'b0000000100000000;
          10: led=16'b0000001000000000;
          11: led=16'b0000010000000000;
          12: led=16'b0000100000000000;
          13: led=16'b0001000000000000;
          14: led=16'b0010000000000000;
          15: led=16'b0100000000000000;
          16: led=16'b1000000000000000;
          17: led=16'b1000000000000000; //'b0001111111111000;
     default: led=16'b0001111001111000;
          endcase
                                  

end
    //counter_to_led u1(Counter,clk_game,led);
assign Led=led; 
assign Score_Left  = score_Left;
assign Score_Right = score_Right;

endmodule
