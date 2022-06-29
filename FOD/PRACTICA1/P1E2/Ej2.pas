program ejercicio2;
type
    archnum = file of integer;
var
   arch_num: archnum;
   num: integer;
   arch_fis: string;
   prom: integer;
   total: integer;
   promedio: integer;
   cant: integer;
begin
//writeln('Ingrese el path del archivo');
//Readln(arch_fis);
arch_fis:='C:\\Users\Bar\FOD\PRACTICA1\P1E1\Archivonumeros.txt';
assign(arch_num, arch_fis);
Writeln('Hice el assign');
Readln();
reset(arch_num);
Writeln('Hice el reset');
Readln();
while (NOT EOF(arch_num)) do begin    // Acá podria utilizar el procedimiento leer como buena práctica pero no es necesario ya que cuando hago el READ
      read(arch_num, num);            //del ultimo elemento de la lista y el puntero se mueve a EOF, de todas maneras estoy trabajando con el dato leido
      writeln(num);                    //antes de preguntar de nuevo por EOF.
      total:= total + 1;
      promedio:= promedio + num;
      if (num < 1500) then cant:= cant +1;
end;
Writeln('Termino de recorrer');
Readln();
close(arch_num);
Writeln('Cant de nros menores a 1500:',+cant);
prom:=1;
Writeln(prom);
Readln();
End.
