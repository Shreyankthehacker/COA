module tb_mux;
reg a,b,s;
wire y;

mux uut(
  .a(a),.b(b),.s(s),.y(y)
);
initial begin
a=0;b=1;s=0;#10;
a=0;b=1;s=1;#10;
end
initial begin
$dumpfile("mux.vcd");
$dumpvars(0,tb_mux);
end 
endmodule