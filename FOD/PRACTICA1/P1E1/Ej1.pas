program ejercicio1;
type
    archnum = file of integer;    // Declaracion archivo de enteros
var
   arch_num: archnum;
   num: integer;
   arch_fis: string;
   prom: real;
   total: integer;
   promedio: integer;
begin
writeln('Ingrese el path del archivo');
Readln(arch_fis);       //Leo la direccion fisica del archivo
assign(arch_num, arch_fis); //asigno al archivo
rewrite(arch_num);  //Lo abro
writeln('Ingrese un número para agregar, o ingrese 30000 para finalizar.');
readln(num);
while (num <> 30000) do begin
      write(arch_num, num);
      readln(num);
end;
close(arch_num);
Readln();
End.
