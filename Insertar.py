import pyodbc
from datetime import datetime
from conexion import conectar_bd 

def insertar_prestamo(codigo_usuario, codigo_ejemplar, fecha_prestamo, fecha_devolucion):
    conexion = conectar_bd()
    if conexion is None:
        print("No se pudo conectar a la base de datos.")
        return
    try:
        cursor = conexion.cursor()
        cursor.execute('''
            INSERT INTO Biblioteca.USUARIO_EJEMPLAR (CODIGO_USUARIO, CODIGO_EJEMPLAR, FECHA_PRESTAMO, FECHA_DEVOLUCION)
            VALUES (?, ?, ?, ?)
        ''', (codigo_usuario, codigo_ejemplar, fecha_prestamo, fecha_devolucion))
        conexion.commit()
        print("Préstamo insertado correctamente.")
    except pyodbc.Error as e:
        print("Error al insertar el préstamo:", e)
    finally:
        conexion.close()

    insertar_prestamo(1, 5, datetime.now(), '2024-12-17')
