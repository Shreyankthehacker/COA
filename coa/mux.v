module mux(
  input a,b,s,
  output y
);
assign y=(~s&a)|(s&b);
endmodule