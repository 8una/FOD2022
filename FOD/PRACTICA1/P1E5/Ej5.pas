{5
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”}
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

