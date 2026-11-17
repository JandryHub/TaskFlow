# TaskFlow

TaskFlow es una aplicación Flutter para que estudiantes organicen sus actividades académicas y sepan cuáles siguen pendientes.

## Ejecutar el proyecto

Requisitos: Flutter SDK y un emulador, teléfono o navegador compatible.

```sh
flutter pub get
flutter run
```

Para ejecutar la versión web en Chrome:

```sh
flutter run -d chrome
```

## Alcance de TaskFlow

**Problema:** necesito organizar actividades académicas y saber cuáles faltan.

**Usuario objetivo:** estudiante que planifica entregas semanales.

### Historias de usuario y criterios de aceptación

1. Como estudiante, quiero listar mis tareas para ver qué debo hacer.
   **Criterio:** la lista muestra título, prioridad y estado de cada tarea.

2. Como estudiante, quiero abrir una tarea para leer su descripción.
   **Criterio:** al tocar una tarjeta aparece el detalle de la tarea elegida, con su identificador.

3. Como estudiante, quiero crear una tarea para registrar un pendiente.
   **Criterio:** un formulario futuro guarda una tarea válida con título, descripción y prioridad.

4. Como estudiante, quiero editar una tarea para corregir sus datos.
   **Criterio:** al guardar cambios, el detalle y la lista muestran los nuevos datos.

5. Como estudiante, quiero eliminar una tarea para retirar actividades que ya no necesito.
   **Criterio:** al confirmar la eliminación, la tarea deja de aparecer en la lista.

En esta entrega están implementados el listado y el detalle con datos locales. El formulario, la edición, la eliminación y la conexión a una API quedan para sesiones posteriores.

### Modelo de datos: `Task`

La entidad se define en `lib/task.dart`:

- `id` (`int`): identificador único de la tarea.
- `title` (`String`): título breve.
- `description` (`String`): detalle de la actividad.
- `priority` (`String`): prioridad Alta, Media o Baja.
- `isCompleted` (`bool`): indica si está completada.
- `userId` (`int`): identificador del usuario propietario.

### Pantallas y API prevista

- **Lista:** presenta las tareas del usuario y permite abrir cada detalle.
- **Detalle:** muestra identificador, título, descripción, prioridad, estado y usuario.
- **Formulario (futuro):** permitirá crear y editar tareas.

| Operación | Método | Endpoint previsto |
|---|---|---|
| Consultar tareas | GET | `/tasks` |
| Consultar una tarea | GET | `/tasks/{id}` |
| Crear una tarea | POST | `/tasks` |
| Editar una tarea | PATCH | `/tasks/{id}` |
| Eliminar una tarea | DELETE | `/tasks/{id}` |

La aplicación todavía no realiza solicitudes HTTP; estas rutas documentan el contrato esperado para una API futura.
