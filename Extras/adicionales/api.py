import requests, json, base64
from requests.structures import CaseInsensitiveDict

print('HERRAMIENTA CREADO BY NIXON MC')
dni = str(input("INGRESA EL DNI:"))

url = "https://api.municallao.gob.pe/pide/public/v1/reniec/dni/buscar"


data = '{"usuario" : "0", "app" : "33", "ip" : "0.0.0.0", "dni" : "%s", "strNumDocumento" : "null"}' % (dni)

headers = {
    "Content-Type" : "application/json"
    }

response = requests.post(url, data=data, headers=headers)

data = response.json()

nombre = data['consultarResponse']['return']['datosPersona']['prenombres']
apellido_uno = data['consultarResponse']['return']['datosPersona']['apPrimer']
apellido_dos = data['consultarResponse']['return']['datosPersona']['apSegundo']
estado = data['consultarResponse']['return']['datosPersona']['estadoCivil']
restri = data['consultarResponse']['return']['datosPersona']['restriccion']
direc = data['consultarResponse']['return']['datosPersona']['direccion']
ubigeo = data['consultarResponse']['return']['datosPersona']['ubigeo']
photo = data['consultarResponse']['return']['datosPersona']['foto']
decodeit = open(f'{dni}.jpg', 'wb')
decodeit.write(base64.b64decode((photo)))
decodeit.close()
print("\nNombre: ", nombre)
print("Primer Apellido:", apellido_uno)
print("Segundo Apellido: ", apellido_dos)
print("Estado de la Persona: ", estado)
print("Restricciones: ", restri)
print("Direccion: ", direc)
print("Ubigeo: ", ubigeo)
print('Foto documento guardada.')

