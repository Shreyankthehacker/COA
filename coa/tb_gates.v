module tb_gates;
  reg a,b;
  wire  y1,y2,y3,y4,y5,y6;

  gates uut(
    .a(a),
    .b(b),
    .y1(y1),
    .y2(y2),
    .y3(y3),
    .y4(y4),
    .y5(y5),
    .y6(y6)

  );
  integer i ;
  initial begin
    $dumpfile("exp1.vcd");
    $dumpvars(0,tb_exp1);
    
    for(i=0;i<4;i=i+1)
    begin
      {a,b} = i; 
      #10;
    end
end
endmodule    