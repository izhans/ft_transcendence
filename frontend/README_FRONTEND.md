# Trascendence — Frontend

Frontend for the Trascendence project, an online Cluedo game developed with React, TypeScript and Vite.

## 1. Tech Stack

- React
- TypeScript 6
- Vite 8
- ESLint
- Docker & Docker Compose

## 2. Requirements

- Docker with Docker Compose
- Make
- Visual Studio Code (optional)
- Dev Containers extension for VS Code (optional)

Node.js, npm and the frontend dependencies do not need to be installed locally.

## 3. Running the Frontend

All Makefile commands must be executed from the **repository root directory**.

### Start the frontend

```bash
make front-up
```

This command builds the frontend Docker image, installs dependencies through the Dockerfile and starts the Vite development server.

Once the container is running, open:

http://localhost:5173

### Available commands

| Command | Description |
|---|---|
| `make front-up` | Build and start the frontend |
| `make front-down` | Stop the frontend without removing its container |
| `make front-build` | Build the frontend Docker image |
| `make front-logs` | Display frontend logs |
| `make front-clean` | Stop and remove the frontend container |
| `make front-fclean` | Remove the frontend container, image and dependency volume |
| `make front-re` | Clean and rebuild the frontend |

These commands target only the frontend service, allowing other services to be managed independently.

**Note:** `make front-fclean` removes the frontend dependency volume. The source code remains in the local repository.

## 4. Development with VS Code

Using VS Code with Dev Containers is optional. Any editor can be used to modify the frontend source code.

### Attach to the running container

1. Ensure Docker Desktop is running.
2. Execute `make front-up` from the repository root.
3. Open Visual Studio Code.
4. Open the Command Palette (`Cmd + Shift + P` on macOS).
5. Select `Dev Containers: Attach to Running Container`.
6. Choose the frontend container (currently `compose-frontend-1`).
7. Open the `/app` folder inside the container.

The container provides the project's Node.js, TypeScript, Vite and ESLint dependencies.

This allows VS Code to use the same development environment as the application without requiring a local Node.js installation.

### File persistence

Docker Compose mounts the local `frontend/` directory into `/app` inside the container.

Changes made to files inside `/app` are reflected in the local project directory.

The `node_modules` directory is stored in a separate Docker volume.

Removing the container or its volumes does not delete the frontend source code stored in the repository.

## 5. Code Validation

The frontend can be validated without installing Node.js locally.

With the frontend container running, execute the following commands from the repository root.

### TypeScript compilation and Vite build

```bash
docker compose -f compose/compose.dev.yaml exec frontend npm run build
```

This checks TypeScript compilation and generates the optimized application files in `dist/`.

### ESLint

ESLint is a static code analysis tool that helps detect potential errors, bad practices and inconsistencies in JavaScript and TypeScript code without executing the application.

It helps maintain code quality and consistency across the frontend team.

To run ESLint:

```bash
docker compose -f compose/compose.dev.yaml exec frontend npm run lint
```

The rules are defined in `eslint.config.js`.

### Dependency security audit

```bash
docker run --rm compose-frontend npm audit
```

This audits the dependencies included in the built frontend image.

The project currently uses an npm override for `minimatch` to address a reported vulnerability. Dependency compatibility should be checked when updating packages.

## 6. Backend Communication

The frontend is prepared to communicate with the Spring Boot backend through HTTP REST.

### HTTP request

```http
GET /api/hello
```

### Development proxy

Vite is configured in `vite.config.ts` to forward requests beginning with `/api` to:

```text
http://host.docker.internal:8080'
```

The frontend expects a successful response containing plain text (`text/plain`).

Expected response:

```text
Hola mundo
```

When the backend is unavailable, the frontend displays:

```text
Backend no disponible todavía
```
