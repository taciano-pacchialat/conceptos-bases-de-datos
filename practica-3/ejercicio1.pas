program ejercicio1;
const
  corte = '100000';
  codigo_eliminar = 77777;
  valor_alto = 9999999;
type
  especie = record
    codigo: Integer;
    nombre_vulgar: string[50];
    nombre_cientifico: string[50];
    altura_promedio: Real;
    descripcion: string[100];
    zona_geografica: string[50];
  end;

  archivo_especie = file of especie;

procedure leer(var archivo: archivo_especie; var registro: especie);
begin
  if (not(Eof(archivo))) then Read(archivo, registro)
  else registro.codigo := valor_alto;
end;

// procedimientos para eliminar marcando
procedure marcar(var archivo: archivo_especie; codigo_eliminar: Integer);
var
  dato: especie;
begin
  Seek(archivo, 0);
  leer(archivo, dato);
  while (dato.codigo <> valor_alto) do begin
    if (dato.codigo = codigo_eliminar) then begin
      Seek(archivo, FilePos(archivo) - 1);
      dato.codigo := codigo_eliminar;
      Write(archivo, dato);
    end;
    leer(archivo, dato);
  end;
end;

procedure compactar(var archivo: archivo_especie; var nuevo_archivo: archivo_especie);
var 
  dato: especie;
begin
  Seek(archivo, 0);
  leer(archivo, dato);
  while (dato.codigo <> valor_alto) do begin
    if (dato.codigo <> codigo_eliminar) then 
      Write(nuevo_archivo, dato);
    leer(archivo, dato);
  end;
end;

// procedimientos para eliminar copiando el ultimo registro
procedure baja_fisica(var archivo: archivo_especie; codigo_eliminar: Integer);
var
  posicion_borrar: Integer;
  dato: especie;
begin
  Seek(archivo, 0); 
  leer(archivo, dato);
  while (dato.codigo <> valor_alto) do begin
    if (dato.codigo = codigo_eliminar) then begin
      posicion_borrar := FilePos(archivo) - 1;
      Seek(archivo, FileSize(archivo) - 1);
      leer(archivo, dato);
      Seek(archivo, FilePos(archivo) - 1);
      Truncate(archivo);
      Seek(archivo, posicion_borrar);
      Write(archivo, dato);
    end;
    leer(archivo, dato);
  end;
end;


begin
  
end.