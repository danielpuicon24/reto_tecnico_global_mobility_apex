# 📋 Gestor de Tareas Avanzado

Reto Técnico – Apex Global Mobility

## 🧠 Descripción

Aplicación móvil desarrollada con **Flutter**, que permite gestionar tareas locales y visualizar una lista de países consumiendo una API pública GraphQL.

Este proyecto sigue una arquitectura limpia (Clean Architecture), implementa **Riverpod** para el manejo de estado, y **Hive** para persistencia local.

---

## ✅ Funcionalidades

### 🗂️ Gestión de Tareas
- Listar tareas
- Crear nueva tarea
- Editar tarea existente
- Marcar como completada
- Eliminar tarea
- Filtrar por:
  - Todas
  - Pendientes
  - Completadas

### 🌐 Países (GraphQL)
- Consumo de la API pública [countries.trevorblades.com](https://countries.trevorblades.com/)
- Pantalla con listado de países

---

## 📐 Arquitectura

La aplicación está dividida en 3 capas siguiendo Clean Architecture:

lib/
├── features/
│ └── countries/
│   ├── data/
│   ├── domain/
│   └── presentation/
│ └── tasks/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── core/
│ └── constants/
│ └── network/
│ └── services/
├── config/
│ └── router/
│ └── theme/
└── main.dart


- `data`: Datasource y repositorios
- `domain`: Entidades y casos de uso
- `presentation`: UI + lógica con Riverpod

---

## 🧪 Testing

Se han implementado:

- ✅ 1 test **unitario** de lógica de negocio (validación, guardado, completado, eliminación, actualización de tareas)
- ✅ 1 test **widget** para verificar elementos clave de la UI

Ubicación:
/test/
├── features/
│   └── countries/
│       └── domain/
│       └── presentation/
│   └── tasks/
│       └── presentation/

🔌 Dependencias principales
- flutter_riverpod
- json_annotation
- hive
- graphql_flutter
- mockito
- flutter_test

📸 Capturas de Pantalla 


🚀 Cómo ejecutar
1. Clona el repositorio:
   git clone [https://github.com/tu_usuario/nombre_del_repo.git](https://github.com/danielpuicon24/reto_tecnico_global_mobility_apex)

2. Instala dependencias:
   flutter pub get
   
4. Ejecuta la app:
   flutter run
   
6. Ejecuta los tests:
   flutter test


👨‍💻 Autor
Jose Daniel Puicón Braco
GitHub: @danielpuicon24

