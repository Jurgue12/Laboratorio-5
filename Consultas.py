import pyodbc
from datetime import datetime
from conexion import conectar_bd 

def consultar_libros(titulo=None):
    conexion = conectar_bd()
    if conexion is None:
        return
    try:
        cursor = conexion.cursor()
        if titulo:
            cursor.execute("SELECT CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL FROM Biblioteca.LIBRO WHERE TITULO LIKE ?", ('%' + titulo + '%',))
        else:
            cursor.execute("SELECT CODIGO_LIBRO, TITULO, ISBN, PAGINAS, EDITORIAL FROM Biblioteca.LIBRO")
        
        libros = cursor.fetchall()
        for libro in libros:
            print(libro)
    except pyodbc.Error as e:
        print("Error al consultar los libros:", e)
    finally:
        conexion.close()

consultar_libros("The Shawshank Redemption")  

def actualizar_autor(codigo_autor, nuevo_nombre):
    conexion = conectar_bd()
    if conexion is None:
        return
    try:
        cursor = conexion.cursor()
        cursor.execute("UPDATE Biblioteca.AUTOR SET NOMBRE = ? WHERE CODIGO = ?", (nuevo_nombre, codigo_autor))
        conexion.commit()
        print("Autor actualizado correctamente.")
    except pyodbc.Error as e:
        print("Error al actualizar el autor:", e)
    finally:
        conexion.close()

actualizar_autor(1, "Rolando Herrera Sanchez")
