import pyodbc

def conectar_bd():
    try:
        conexion = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-M87PMNF;'
            'DATABASE=Biblioteca;'
            'Trusted_Connection=yes;'
        )
        print("Conexión exitosa a la base de datos.")
        return conexion
    except pyodbc.Error as e:
        print("Error al conectar a la base de datos:", e)
        return None

