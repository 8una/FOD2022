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
procedure menu (var archivoLogico: archivoEmpleados; nombre: String);
var opcion: integer;
begin
    writeln ('INGRESE 1 PARA CREAR EL ARCHIVO',+nombre,+'Y CARGAR DATOS');
	writeln ('INGRESE 2 PARA LISTARPORS');
    writeln ('INGRESE 3 PARA RECORRER');
    writeln ('INGRESE 4 PARA MAYORES70');

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
end;
end;
var
archivoLogico: archivoEmpleados;
nombre: String;
loop: boolean;
letra: char;
begin
	loop:= true;
	textcolor(green);
	clrscr;
	arbiboBibico(nombre);
	Assign(archivoLogico, nombre);
	menu (archivoLogico,nombre);
	while (loop) do begin
		write ('SI INGRESA CUALQUIER CARACTER SE DESPLEGARA NUEVAMENTE EL MENU. SI INGRESA E SE CERRARA LA CONSOLA: '); readln (letra);
		if (letra = 'E') or (letra = 'e') then
			loop:= false
		else begin
			clrscr;
			menu (archivoLogico,nombre);
		end;
  end;
End.
