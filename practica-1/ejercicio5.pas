program ejercicio5;
type
  cadena = String[20];
  flor = record
    numero: Integer;
    altura: Double;
    nombre_cientifico: cadena;
    nombre_vulgar: cadena;
    color: cadena;
  end;
  archivo_flor = file of flor;

procedure leer_flor(var dato: flor);
begin
  Write('Nombre cientifico: ');
  ReadLn(dato.nombre_cientifico);
  if (dato.nombre_cientifico <> 'zzz') then begin
    Write('Numero: ');
    ReadLn(dato.numero);
    Write('Altura: ');
    ReadLn(dato.altura);
    Write('Nombre vulgar: ');
    ReadLn(dato.nombre_vulgar);
    Write('Color: ');
    ReadLn(dato.color);
  end;
end;

procedure cargar_archivo(var archivo: archivo_flor; var mayor_altura, menor_altura: Double; var nombre_mayor_altura, nombre_menor_altura: cadena; var cantidad: Integer);
var actual: flor;
begin
  leer_flor(actual);
    while(actual.nombre_cientifico <> 'zzz') do begin
      Write(archivo, actual);

      // maximo, minimo y cantidad
      cantidad := cantidad + 1;
      if (actual.altura > mayor_altura) then begin
        mayor_altura := actual.altura;
        nombre_mayor_altura := actual.nombre_vulgar;
      end;
      if (actual.altura < menor_altura) then begin
        menor_altura := actual.altura;
        nombre_menor_altura := actual.nombre_vulgar;
      end;
      leer_flor(actual);
    end;
end;

procedure reportar(nombre_mayor_altura, nombre_menor_altura: cadena; cantidad: Integer);
begin
  WriteLn('Nombre de la especie con mayor altura: ', nombre_mayor_altura);
  WriteLn('Nombre de la especie con menor altura: ', nombre_menor_altura);
  WriteLn('Cantidad de especies: ', cantidad);
end;

procedure listar_a_terminal(var archivo: archivo_flor);
var auxiliar: flor;
begin
  Seek(archivo, 0);
  while (not Eof(archivo)) do begin
    Read(archivo, auxiliar);
    Write('Numero: ');
    WriteLn(auxiliar.numero);
    Write('Altura: ');
    WriteLn(auxiliar.altura);
    Write('Nombre cientifico: ');
    WriteLn(auxiliar.nombre_cientifico);
    Write('Nombre vulgar: ');
    WriteLn(auxiliar.nombre_vulgar);
    Write('Color: ');
    WriteLn(auxiliar.color);
    WriteLn();
  end;
end;

procedure modificar_variable(var archivo: archivo_flor; nombre: cadena);
var auxiliar: flor;
begin
  Seek(archivo, 0);
  Read(archivo, auxiliar);
  while (not Eof(archivo) and (auxiliar.nombre_vulgar <> 'Victoria amazonia')) do begin
    if (not Eof(archivo)) then begin
      Seek(archivo, FilePos(archivo) - 1);
      auxiliar.nombre_vulgar := nombre;
      Write(archivo, auxiliar);
    end;
  end;
  Seek(archivo, 0);
end;

procedure listar_a_archivo(var archivo: archivo_flor);
var
  auxiliar: flor;
  archivo_texto: Text;
begin
  Assign(archivo_texto, 'flores.txt');
  Rewrite(archivo_texto);
  Seek(archivo, 0);
  while (not Eof(archivo)) do begin
    Read(archivo, auxiliar);
    Write(archivo_texto, auxiliar.numero, auxiliar.altura);
    WriteLn(archivo_texto, auxiliar.nombre_cientifico);
    WriteLn(archivo_texto, auxiliar.nombre_vulgar);
    WriteLn(archivo_texto, auxiliar.color);
  end;
end;

var
  archivo: archivo_flor;
  nombre_archivo: cadena;
  cantidad_especies: Integer;
  mayor_altura: Double;
  menor_altura: Double;
  nombre_mayor_altura: cadena;
  nombre_menor_altura: cadena;
  opcion: Integer;
begin
  mayor_altura := -1;
  menor_altura := 9999;
  cantidad_especies := 0;
  Write('Nombre del archivo: ');
  ReadLn(nombre_archivo);
  // carga del archivo
  if (nombre_archivo <> '') then begin
    Assign(archivo, nombre_archivo);
    Reset(archivo);
    cargar_archivo(archivo, mayor_altura, menor_altura, nombre_mayor_altura, nombre_menor_altura, cantidad_especies);
    // menu
    while True do begin
      WriteLn('Seleccione una opcion: ');
      WriteLn('1: reportar');
      WriteLn('2: listar todo el archivo');
      WriteLn('3: modificar victoria amazonia');
      WriteLn('4: append mas especies');
      WriteLn('5: listar a flores.txt');
      ReadLn(opcion);
      if (opcion = 1) then
        reportar(nombre_mayor_altura, nombre_menor_altura, cantidad_especies)
      else if (opcion = 2) then
        listar_a_terminal(archivo)
      else if (opcion = 3) then
        modificar_variable(archivo)
      else if (opcion = 4) then
        cargar_archivo(archivo, mayor_altura, menor_altura, nombre_mayor_altura, nombre_menor_altura, cantidad_especies)
      else if (opcion = 5) then
        listar_a_archivo(archivo)
      else 
        Break;
    end;
  end;
end.