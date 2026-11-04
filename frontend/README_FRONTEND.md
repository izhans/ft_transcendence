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