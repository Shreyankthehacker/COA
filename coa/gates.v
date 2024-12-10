module gates(
  input a,b,
  output y1,y2,y3,y4,y5,y6
);

  assign y1 = a&b;
  assign y2 = !y1;
  assign y3 = a|b;
  assign y4 = !y3;
  assign y5 = (a^b);
  assign y6 = !y5;

endmodule

