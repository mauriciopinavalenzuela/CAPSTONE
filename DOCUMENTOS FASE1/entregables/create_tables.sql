CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    rut VARCHAR(12) UNIQUE NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    password_hash TEXT NOT NULL,
    rol VARCHAR(20) DEFAULT 'vecino',  -- admin, directorio, vecino
    estado VARCHAR(20) DEFAULT 'activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE certificados (
    id_certificado SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    tipo_certificado VARCHAR(50) NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente',
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_emision TIMESTAMP,
    numero_certificado VARCHAR(30) UNIQUE,
    motivo_solicitud TEXT
);

CREATE TABLE proyectos_vecinales (
    id_proyecto SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    lugar VARCHAR(100),
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE actividades (
    id_actividad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    lugar VARCHAR(100),
    organizador INT REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    estado VARCHAR(20) DEFAULT 'activo'
);

CREATE TABLE espacios (
    id_espacio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    capacidad_maxima INT,
    horario_apertura TIME,
    horario_cierre TIME,
    estado VARCHAR(20) DEFAULT 'disponible'
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_espacio INT REFERENCES espacios(id_espacio) ON DELETE CASCADE,
    id_usuario INT REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE notificaciones (
    id_notificacion SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    titulo VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    tipo VARCHAR(30),
    estado VARCHAR(20) DEFAULT 'pendiente',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE noticias (
    id_noticia SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    contenido TEXT NOT NULL,
    autor INT REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'publicada'
);