{Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}
program P1E5;
uses crt;

type

    celular= record
        cod: integer;
        precio: integer;
        marca: String;
        stock: integer;
        stockmin: integer;
        desc: String;
        nombre: String;
    end;

    archivoLogico = file of celular;
procedure CrearDesdeTxt (var arch: archivoLogico; var carga: Text);
var
celu: celular;
begin
reset(carga); // mi archivo de texto con info de celulares
rewrite(arch); // mi archivo de celulares vacio
while not EOF(carga) do begin   
    Readln(carga, celu.cod,celu.precio,celu.marca);
    Readln(carga, celu.stock,celu.stockmin,celu.desc);
    Readln(carga, celu.nombre);
    Write(arch, celu);
end;
	close (carga);
	close (arch);
end;

{Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo}
procedure ListarStockMenor(var arch: archivoLogico);
var c: celular; stock: boolean;
begin
     stock:= false;
     reset(arch);
     while not EOF(arch) do begin
           Read(arch, c);
           if (c.stock < c.stockmin) then begin
           Writeln('El celular ',+c.cod,+' marca ',+c.marca,+'posee un stock inferior al stock minimo');
           stock:= true;
           end;
     end;
     if NOT (stock) then writeln('No se encontraron celulares con stock inferior al stock minimo');
     close(arch);
end;

{b. Modificar el stock de un celular dado.   }
procedure ModificarStock(var arch: archivoLogico);
var c: celular; stock: integer; v: boolean;
begin
     v:= false;
     Writeln('Ingrese codigo celular');
     Readln(stock);
     reset(arch);
     while not EOF(arch) and not v do begin
           Read(arch, c);
           if (c.cod = stock) then begin
           Writeln('ingrese nuevo stock');
           readln(stock);
           c.stock:= stock;
           v:= true;
           Write (arch, c);
           //hacer el filepos
           end;
     end;
     if NOT (v) then writeln('No se encontraron celulares con stock inferior al stock minimo');
     close(arch);
end;



procedure ListarDescripcion(var arch: archivoLogico);
var d: String; c: celular;
begin
    reset(arch);
    Writeln('Ingrese la descripcion a buscar');
    readln(d);
    while not EOF(arch) do begin
          Read(arch, c);
          if (c.desc = d) then Writeln('Se encontro');
    end;
    close(arch);

end;

procedure exportaratxt (var arc_log:archivoLogico; var celu2:Text);
var
	c:celular;
begin
	rewrite (celu2);
	reset (arc_log);
	while not eof (arc_log) do begin
		read (arc_log,c);
		with c do begin
		writeln (celu2,'|CODIGO: ',cod,' |PRECIO: ',precio,' |MARCA: ',marca,'|STOCK DISPONIBLE: ',stock,' |STOCK MINIMO: ',stockmin,'|DESCRIPCION:',desc,' |NOMBRE: ',nombre);
		end;
	end;
	writeln ('SE EXPORTO CON EXITO');
	close (arc_log);
	close (celu2);
end;


procedure AgregarFinal(var arch: archivoLogico; c: celular);
begin
     Writeln('Ingrese datos celular para agregar al final');      //esto podria ser un procedure
Readln(c.cod);
Readln(c.precio);
Readln(c.marca);
Readln(c.stock);
Readln(c.stockmin);
Readln(c.desc);
Readln(c.nombre);

     reset(arch);
     while not EOF(arch) and not v do begin
           Read(arch, c);
           if (c.cod = stock) then begin
           Writeln('ingrese nuevo stock');
           readln(stock);
           c.stock:= stock;
           v:= true;
           Write (arch, c);
           //hacer el filepos
           end;
     end;
     if NOT (v) then writeln('No se encontraron celulares con stock inferior al stock minimo');
     close(arch);
end;


procedure menu(var arch: archivoLogico; var carga,exportar2: Text);
var opcion: integer;
begin
writeln ('1) Crear archivo de celulares, cargando datos desde celulares.txt'); 
writeln ('2) Listar celulares que tienen menos stock que el stock minimo');
writeln ('3) Listar en pantalla los celulares del archivo cuya descripcion contenga una cadena de caracteres proporcionada por el usuario.');
writeln ('4) Exportar el archivo a un txt celulares.txt');
write (' Ingrese opcion: '); readln(opcion);
       case opcion of
            1:begin

                   CrearDesdeTxt(arch,carga);
                   end;

            2:begin
                ListarStockMenor(arch);
            end;

            3:begin
                ListarDescripcion(arch);
            end;

            4:begin
                ExportarATxt(arch, exportar2);
            end;            
end;
end;
var
carga, exportar: Text;
arch: archivoLogico;
loop: boolean;
letra: char;
begin
loop:= true;
textcolor(red);
assign(carga,'C:\\Users\Bar\FOD\PRACTICA1\P1E5\celulares.txt'); // archivo de celus q yo edito con bloc d notas
assign(arch,'C:\\Users\Bar\FOD\PRACTICA1\P1E5\nuevo.txt'); // celulares binario
assign(exportar,'C:\\Users\Bar\FOD\PRACTICA1\P1E5\celulares2.txt');
menu(arch, carga, exportar);
while (loop) do begin
		write ('SI INGRESA CUALQUIER CARACTER SE DESPLEGARA NUEVAMENTE EL MENU. SI INGRESA E SE CERRARA LA CONSOLA: '); readln (letra);
		if (letra = 'E') or (letra = 'e') then
			loop:= false
		else begin
			clrscr;
               menu(arch, carga, exportar);
		end;
  end;
end.

