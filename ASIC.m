#Carga del paquete
pkg load control

#Sistema de ejemplo
G=tf(
  [5,2], #Coeficientes P Numerador
  [1,4,20] #Coeficientes Q Denominador
  )

#Grafico de polos y zeros de ejemplo
pzmap(G)

input("Press any key to exit");
