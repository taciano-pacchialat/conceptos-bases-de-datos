program ejercicio3;

type
  producto = record
    codigo: Integer;
    nombre: String;
    descripcion: String;
    stock: Integer;
  end;

  texto = Text;
  binario = file of producto;

procedure leer_registro(var registro: producto)
begin
  Write('Codigo: ');
  ReadLn(registro.codigo);
  Write('Nombre: ');
  ReadLn(registro.nombre);
  Write('Descripcion: ');
  ReadLn(registro.descripcion);
  Write('Stock: ');
  ReadLn(registro.stock);
end;

// a
procedure texto_a_binario(var archivo_texto: texto; var archivo_binario: binario)
var registro: producto;
begin
  Reset(archivo_texto);
  Assign(archivo_binario, 'ejercicio3');
  Rewrite(archivo_binario);
  while (not Eof(archivo_texto)) do
    begin
      ReadLn(archivo_texto, registro.codigo, registro.stock, registro.nombre);
      ReadLn(archivo, registro.descripcion);
      Write(archivo_binario, registro);
    end;
  Close(archivo_texto);
  Close(archivo_binario);
end;

// b
procedure marcar_obsoletos(var archivo: binario)
var
  codigo_eliminar: Integer;
  registro: producto;
begin
  Reset(archivo);
  codigo_eliminar := -1;
  registro.codigo := -1;
  WriteLn('INTRODUZCA 0 PARA TERMINAR');
  while (codigo_eliminar <> 0) do
    begin
      Write('Introduzca un codigo: ');
      ReadLn(codigo_eliminar);
      // busco el registro con el codigo que lei desde teclado
      while ((not(Eof(archivo))) and (registro.codigo <> codigo_eliminar)) do 
        begin
          Read(archivo, registro);
        end; 
      // si esta en el archivo, le pongo el codigo negativo
      if (not(Eof(archivo))) then
        begin
          Seek(archivo, FilePos(archivo) - 1);
          registro.codigo := registro.codigo * (-1);
          WriteLn(archivo, registro.codigo, registro.stock, registro.nombre);
          WriteLn(archivo, registro.descripcion);
        end;
    end;
end;

// c
procedure agregar_por_teclado(var archivo: binario);
var 
  registro: producto;
begin
  Reset(archivo);
  leer_registro(registro);
  Seek(archivo, FileSize(archivo));
  Write(archivo, registro);
  Close(archivo);
end;

// d
// supongo que el numero se almacena donde va el codigo
procedure baja_con_lista(var archivo: binario)
var
  cabecera, aux: producto;
  numero_libre, numero_eliminar: Integer;
begin
  Reset(archivo);
  Write('Ingrese el codigo a eliminar: ');
  ReadLn(numero_eliminar);

  Read(archivo, cabecera);
  aux := cabecera;
  while (not(Eof(archivo)) and (aux.codigo <> numero_eliminar)) do 
    Read(archivo, aux);
  if (Eof(archivo)) then
    WriteLn('El producto no se encuentra en el archivo')
  else begin
    numero_libre := FilePos(archivo) - 1;
    Seek(archivo, numero_libre);
    Write(archivo, cabecera);
    aux.codigo := numero_libre;
    Seek(0);
    Write(archivo, aux);
  end;
  Close(archivo);
end;

// e
procedure alta_con_lista(var archivo: binario)
var 
  nuevo, aux, cabecera: producto;
begin
  Reset(archivo);
  Read(archivo, cabecera);
  leer_registro(nuevo);

  if (cabecera.codigo = -1) then
    Seek(archivo, FileSize(archivo))
  else
  begin
    Seek(archivo, cabecera.codigo);
    Read(archivo, aux);
    Seek(archivo, 0);
    Write(archivo, aux);
    Seek(archivo, cabecera.codigo);
  end;
  Write(archivo, nuevo);
  Close(archivo);
end;

// f
procedure texto_a_binario_lista(var archivo_texto: texto; var archivo_binario: binario)
var
  nuevo: producto;
begin
  Reset(archivo_texto);
  Assign(archivo_binario, 'ejercicio3');
  Rewrite(archivo_binario);
  // la unica diferencia para este procedimiento es la cabecera
  nuevo.codigo := -1;
  Write(archivo_binario, nuevo);

  while (not Eof(archivo_texto)) do
    begin
      ReadLn(archivo_texto, registro.codigo, registro.stock, registro.nombre);
      ReadLn(archivo, registro.descripcion);
      Write(archivo_binario, registro);
    end;

  Close(archivo_texto);
  Close(archivo_binario);
end;

begin
  {
    Sin lista: mas eficiente en terminos de tiempo de ejecucion, pero utiliza mas memoria (fragmentacion).
    Con lista: menor uso de la memoria pero tarda mas en ejecutarse ya que consta de mas operaciones.
  }
End.