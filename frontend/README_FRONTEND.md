# Frontend — ft_transcendence

Frontend application for the ft_transcendence project, built with React, TypeScript and Vite.

## Tech Stack

- **React:** User interface development.
- **TypeScript:** Static type checking.
- **Vite:** Development server and build tool.
- **ESLint:** Code quality and static analysis.

## Requirements

Make sure **Node.js and npm** are installed on your system.

## Running the Frontend Locally

From the project root, navigate to the `frontend/` directory.

Install the project dependencies:

```bash
npm ci
```

Start the development server:

```bash
npm run dev
```

The application will be available at:

**http://localhost:5173**

## Backend Communication

The frontend sends an HTTP `GET` request to `/api` and displays the plain-text response received from the Spring Boot backend.

The expected response is:

- **HTTP status:** `200 OK`
- **Content-Type:** `text/plain`
- **Response body:** `Hola mundo`

The message must come directly from the backend and is not hardcoded in React.

During local development, Vite forwards requests to `/api` to the Spring Boot backend running at `http://localhost:8080`.

The backend must be running for the request to succeed. If it is unavailable, the frontend displays an error message.

### Available commands from the Makefile

| Command | Description |
|---|---|
| `make front-up` | Build and start the frontend |
| `make front-down` | Stop the frontend without removing its container |
| `make front-build` | Build the frontend Docker image |
| `make front-logs` | Display frontend logs |
| `make front-clean` | Stop and remove the frontend container |
| `make front-fclean` | Remove the frontend container, image and dependency volume |
| `make front-re` | Clean and rebuild the frontend |
| `make help-front` | Display the available frontend commands |

These commands target only the frontend service, allowing other services to be managed independently.

**Note:** `make front-fclean` removes the frontend dependency volume. The source code remains in the local repository.