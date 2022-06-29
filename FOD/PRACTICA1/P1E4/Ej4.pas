program MenuEj3;
uses crt;
type
//C:\\Users\Bar\Desktop\FUNDAMENTOS\empleado.txt

                        {DECLARACION DE ESTRUCTURA}
{=========================================================================}
empleado = record
         nroEmp: integer;
         apellido: String;
         nombre: String;
         edad: integer;
         DNI: integer;
         end;
archivoEmpleados = file of empleado;

                                 {PROCESOS}
{=========================================================================}

procedure arbiboBibico(var nombre: string);
begin
     Writeln('INGRESE EL NOMBRE DEL ARCHIVO');
     readln(nombre);
end;
{=========================================================================}
procedure LeerEmpleado(var emp: empleado);
begin
readln(emp.apellido);
if (emp.apellido<>'fin') then begin
   with emp do begin
   write('Ingrese nombre:');readln(nombre);
   write('Ingrese nro de empleado:');readln(nroEmp);
   write('Ingrese edad:');readln(edad);
   write('Ingrese dni:');readln(DNI);
end;
end;
end;

{Crear un archivo de registros no ordenados de empleados desde teclado.}
{=========================================================================}

procedure Crear(var archivoLogico:archivoEmpleados);
var emp: empleado;
begin
     rewrite(archivoLogico);
     writeln('Ingrese un apellido de empleado, o ingrese fin para finalizar.');
     LeerEmpleado(emp);
     while (emp.apellido <> 'fin') do begin
           write(archivoLogico, emp);
           writeln('Ingrese un apellido de empleado, o ingrese fin para finalizar.');
           LeerEmpleado(emp);
end;
close(archivoLogico);
Writeln('Carga finalizada con exito');
Readln();
end;


{Listar datos de empleados con un nombre o apellido determinados}
{LO MISMO Q VI ANTES: como aca hago el read, trabajo con lo que traje, y luego pregunto por EOF, no pierdo ningun dato que pudiera estar al final del archivo}
{=========================================================================}
procedure ListarPorS(var archivoLogico:archivoEmpleados);
var nombre: String; emp: empleado;
begin
     reset(archivoLogico);
     Write('Ingrese el nombre o apellido a buscar:');Readln(nombre);
     While NOT EOF(archivoLogico) do begin
        Read(archivoLogico, emp);
		if (emp.apellido = nombre) or (emp.nombre = nombre) then begin
	with emp do begin
		writeln ('NRO: ',nroEmp);
		writeln ('APELLIDO: ',apellido);
		writeln ('NOMBRE: ',nombre);
		writeln ('EDAD: ',edad);
		writeln ('DNI: ',dni);
		writeln ('');
	end;
		end;	
        Writeln('Quizas no haya entrado al if');
        end;
     close(archivoLogico);
end;


procedure Recorrer(var archivoLogico:archivoEmpleados);
var emp: empleado;
begin
     reset(archivoLogico);
     While NOT EOF(archivoLogico) do begin
        Read(archivoLogico, emp);
        Writeln(emp.apellido);
     end;
     Writeln('Recorrido finalizado');
     close(archivoLogico);
     Readln();
end;
procedure Mayores70(var archivoLogico:archivoEmpleados);
var emp: empleado;
begin
     reset(archivoLogico);
     While NOT EOF(archivoLogico) do begin
        Read(archivoLogico, emp);
        if (emp.edad>70) then writeln(emp.apellido,emp.nombre);
     end;
     Writeln('Recorrido finalizado');
     close(archivoLogico);
     Readln();
end;
procedure Agregar(var archivoLogico:archivoEmpleados);
var emp: empleado;
begin
     reset(archivoLogico);
     Writeln('Ingrese el apellido del empleado que desea agregar o fin para finalizar');
     LeerEmpleado(emp);
     while (emp.apellido<>'fin') do begin
           seek(archivoLogico, fileSize(archivoLogico)); // me posiciono en la ultima posicion del archivo para agregar, probar si necesito el -1, creo q no
           Write(archivoLogico, emp);
           Writeln('Ingrese el apellido del empleado que desea agregar o fin para finalizar');
           Readln(emp.apellido);
     end;
     Writeln('Carga finalizada');
     close(archivoLogico);
     Readln();
end;

procedure ModificarEdad(var archivoLogico:archivoEmpleados);
var nroEmpleado: integer; emp: empleado; encontre: boolean;
begin
     reset(archivoLogico);
     encontre:= false;
     Write('Ingrese el numero de empleado a buscar:');Readln(nroEmpleado);
     While NOT EOF(archivoLogico) and NOT (encontre) do begin
        Read(archivoLogico, emp);
        if (emp.nroEmp=nroEmpleado) then begin
            encontre:= true;
            Writeln('Se ha encontrado al empleado:',+emp.nombre,+emp.apellido);
            Writeln('Ingrese una nueva edad. Edad actual: ',+emp.edad);
            Readln(emp.edad);
            Write(archivoLogico, emp);
        end;
     end;
     if NOT(encontre) then writeln('No se encontro el empleado solicitado');
     Readln();

     close(archivoLogico);
     end;
procedure exportarATxt(var archivoLogico: archivoEmpleados; var txt: Text);
var
	e: empleado;
begin
reset(archivoLogico);
rewrite(txt);
while not EOF (archivoLogico) do begin
    read(archivoLogico, e);
    with e do writeln (txt,'|NRO: ',nroEmp:10,'|EDAD: ',edad:10,'|DNI: ',dni:10,'|APELLIDO: ',apellido:10,'|NOMBRE: ',nombre:10);
end;
close(archivoLogico);
close(txt);
end;

procedure DniEn0(var archivoLogico:archivoEmpleados; var dni:Text);
var
   e: empleado;
begin
     reset(archivoLogico);
     rewrite(dni);
     While NOT EOF(archivoLogico) do begin
        Read(archivoLogico, e);
	if (e.DNI=0) then begin
              Writeln('entre a la escritura');
                 Writeln(dni,'HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
	end;
     end;
     Writeln('Recorrido finalizado');
     close(archivoLogico);
     close(dni);
     Readln();
end;
procedure menu (var archivoLogico: archivoEmpleados; nombre: String; var txt: Text; var dnitxt: Text);
var opcion: integer;
begin
    writeln ('INGRESE 1 PARA CREAR EL ARCHIVO',+nombre,+'Y CARGAR DATOS');
	writeln ('INGRESE 2 PARA LISTARPORS');
    writeln ('INGRESE 3 PARA RECORRER');
    writeln ('INGRESE 4 PARA MAYORES70');
    writeln ('INGRESE 5 PARA AGREGAR EMPLEADO AL FINAL');
    writeln ('INGRESE 6 PARA EXPORTAR A TXT');
    writeln ('INGRESE 7 PARA MODIFICAR EDAD');
    writeln ('INGRESE 8 PARA EXPORTAR DNI 0');
	write (' Ingrese opcion: '); readln(opcion);
       case opcion of
            1:begin
                   Crear(archivoLogico);
                   end;

            2:begin
                ListarPorS(archivoLogico);
            end;

            3:begin
                Recorrer(archivoLogico);
            end;

            4:begin
                Mayores70(archivoLogico);
            end;
            5:begin
                Agregar(archivoLogico);
            end;
            6:begin
                exportarATxt(archivoLogico, txt);
            end;
            7:begin
                modificarEdad(archivoLogico);
            end;
            8:begin
                DniEn0(archivoLogico, dnitxt);
            end;

end;
end;
var
archivoLogico: archivoEmpleados;
nombre: String;
loop: boolean;
letra: char;
todos_emp,dni0: Text;
begin
	loop:= true;
	textcolor(green);
	clrscr;
	arbiboBibico(nombre);
	Assign(archivoLogico, nombre);
    Assign(todos_emp,'C:\\Users\Bar\FOD\PRACTICA1\P1E4\todosemp.txt');
    Assign(dni0,'C:\\Users\Bar\FOD\PRACTICA1\P1E4\faltadni.txt');
	menu(archivoLogico,nombre,todos_emp,dni0);
	while (loop=true) do begin
		write ('SI INGRESA CUALQUIER CARACTER SE DESPLEGARA NUEVAMENTE EL MENU. SI INGRESA E SE CERRARA LA CONSOLA: '); readln (letra);
		if (letra = 'E') or (letra = 'e') then
			loop:= false
		else begin
			clrscr;
			menu (archivoLogico,nombre,todos_emp,dni0);
		end;
  end;
End.
