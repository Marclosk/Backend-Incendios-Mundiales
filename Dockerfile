# Usa una imagen base de Node.js
FROM node:14

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia package.json y package-lock.json al directorio de trabajo
COPY package*.json ./

# Instala las dependencias del backend
RUN npm install

# Copia todo el código fuente del backend al contenedor
COPY . .

# Exposición del puerto
EXPOSE 3001

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
