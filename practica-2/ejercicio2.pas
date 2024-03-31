program ejercicio2;
type
  cadena = string[20];
  cd = record
    codigo: Integer;
    nombre_artista: cadena;
    nombre_disco: cadena;
    genero: cadena;
    cantidad_vendida: Integer;
  end;
  archivo_cd = file of cd;

procedure leer(var archivo: archivo_cd; var registro: cd);
begin
  if (not(Eof(archivo))) then
    Read(archivo, registro);
end;

var
  registro: cd;
  archivo: archivo_cd;
  texto: Text;
  autor_actual: Integer;
  genero_actual: cadena;
  disco_actual: cadena;
  cantidad_genero: Integer;
  cantidad_autor: Integer;
  cantidad_total: Integer;
  cantidad_disco: Integer;
begin
  Assign(archivo_cd, 'cds');
  Reset(archivo_cd);
  Assign(texto, 'archivo-texto.txt');
  Rewrite(texto);
  cantidad_total := 0;
  while (not(Eof(archivo_cd))) do begin
    leer(archivo_cd, registro);
    autor_actual := registro.codigo;
    genero_actual := registro.genero;
    disco_actual := registro.nombre_disco;
    cantidad_autor := 0;
    while (registro.codigo = autor_actual) do begin
      WriteLn(texto, 'Autor: ', registro.nombre_artista);
      cantidad_autor := cantidad_autor + 1;
      cantidad_genero := 0;
      while (registro.genero = genero_actual) do begin
        cantidad_genero := cantidad_genero + 1;
        cantidad_disco := 0;
        while (registro.codigo = disco_actual) do begin
          Write(texto, 'Nombre disco: ', registro.nombre_disco, ' ');
          cantidad_disco := cantidad_disco + 1;
          cantidad_total := cantidad_total + 1;
          leer(archivo_cd, registro);
        end;
        WriteLn(texto, 'cantidad vendida: ', cantidad_disco);
      end;
      WriteLn(texto, 'Genero: ', registro.genero, 'cantidad vendida: ', cantidad_genero);
    end;
    WriteLn(texto, 'Total Autor: ', cantidad_autor);
  end;
  WriteLn(texto, 'Total discografica: ', cantidad_total);
end.