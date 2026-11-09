# Makefile 1.0 #

.DEFAULT_GOAL := build-frontend

# variables #

#Dirs
FRONT_DIR=frontend
BACKEND_DIR=backend
COMPOSE_DIR=.

#image names
FRONT_IMAGE_NAME=trascendence_frontend
BACKEND_IMAGE_NAME=trascendence_backend

#container names
FRONT_CONTAINER_NAME=frontend_container
BACK_CONTAINER_NAME=backend_container


# Reglas #


################
# Por servicio #
################

##### FRONTEND ######

#Construir imagen frontend (make build-frontend)

build-frontend:
	@docker build --pull -f ${FRONT_DIR}/Dockerfile -t ${FRONT_IMAGE_NAME} ${FRONT_DIR}
	@echo "Imagen Frontend construida correctamente"

#ReConstruir imagen frontend sin cache (make rebuild-frontend)

rebuild-frontend:
	@docker build --pull --no-cache -f ${FRONT_DIR}/Dockerfile -t ${FRONT_IMAGE_NAME} ${FRONT_DIR}
	@echo "Imagen Frontend reconstruido correctamente"

#Ejecutar constainer frontend (make run frontend)
run-frontend:
	@docker rm -f ${FRONT_CONTAINER_NAME} >/dev/null 2>&1
	@echo "Borrados los containers:${FRONT_CONTAINER_NAME} que exisitenesen en ejecucion o parados"
	@docker run -d --name ${FRONT_CONTAINER_NAME} -p 5173:5173 ${FRONT_IMAGE_NAME} > /dev/null
	@echo "Creado contenedor ${FRONT_CONTAINER_NAME}"
	@echo "Si quieres ver los logs: haz \"make run-frontend-logs\""
	@echo "Parar su ejecucion haz \"make stop-${FRONT_CONTAINER_NAME}\""


#Ejecutar constainer frontend con logs (make run frontend logs)
run-frontend-logs:
	@docker rm -f ${FRONT_CONTAINER_NAME} >/dev/null 2>&1
	@echo "Borrados los containers:${FRONT_CONTAINER_NAME} que exisitenesen en ejecucion o parados"
	@docker run -d --name ${FRONT_CONTAINER_NAME} -p 5173:5173 ${FRONT_IMAGE_NAME} > /dev/null && gnome-terminal --title="Frontend Docker Logs" -- bash -c "docker logs -f ${FRONT_CONTAINER_NAME}; exit"
	@echo "Creado contendor ${FRONT_CONTAINER_NAME} y creando ventana para ver logs"
	@echo "Parar su ejecucion haz \"make stop-${FRONT_CONTAINER_NAME}\""


#Bajar container frontend (make down backend)
stop-frontend:
	@if [ -n "$$(docker ps -q --filter "name=^/$(FRONT_CONTAINER_NAME)$$")" ]; then \
		docker rm -f $(FRONT_CONTAINER_NAME) > /dev/null 2>&1; \
		echo "Container $(FRONT_CONTAINER_NAME) detenido y eliminado"; \
	elif [ -n "$$(docker ps -aq --filter "name=^/$(FRONT_CONTAINER_NAME)$$")" ]; then \
		docker rm $(FRONT_CONTAINER_NAME) > /dev/null 2>&1; \
		echo "Container $(FRONT_CONTAINER_NAME) eliminado"; \
	else \
		echo "No existe ningún container $(FRONT_CONTAINER_NAME)"; \
	fi

#Levantar servicio frontend
frontend: build-frontend run-frontend

#Levantar servicio frontend con logs
frontend-logs: build-frontend run-frontend-logs



###### BACKEND ######

#Construir imagen backend (make build-backend)
build-backend:
	@docker build --pull -f ${BACKEND_DIR}/Dockerfile -t ${BACKEND_IMAGE_NAME} ${BACKEND_DIR}
	@echo "Imagen Backend construida correctamente"

#Reconstruir imagen backend sin cache (make rebuild-backend)
rebuild-backend:
	@docker build --pull --no-cache -f ${BACKEND_DIR}/Dockerfile -t ${BACKEND_IMAGE_NAME} ${BACKEND_DIR}
	@echo "Imagen Backend reconstruida correctamente"

#Ejecutar container backend (make run-backend)
run-backend:
	@docker rm -f ${BACK_CONTAINER_NAME} >/dev/null 2>&1
	@echo "Borrados los containers:${BACK_CONTAINER_NAME} que exisitenesen en ejecucion o parados"
	@docker run -d --name ${BACK_CONTAINER_NAME} -p 8080:8080 ${BACKEND_IMAGE_NAME} > /dev/null
	@echo "Creado contendor ${BACK_CONTAINER_NAME}"
	@echo "Si quieres ver los logs: haz \"make run-backend-logs\""
	@echo "Parar su ejecucion haz \"make stop-${BACK_CONTAINER_NAME}\""

#Ejecutar container backend con logs (make run-backend-logs)
run-backend-logs: 
	@docker rm -f ${BACK_CONTAINER_NAME} >/dev/null 2>&1
	@echo "Borrados los containers:${BACK_CONTAINER_NAME} que exisitenesen en ejecucion o parados"
	@docker run -d --name ${BACK_CONTAINER_NAME} -p 8080:8080 ${BACKEND_IMAGE_NAME} > /dev/null && gnome-terminal --title="Backend Docker Logs" -- bash -c "docker logs -f ${BACK_CONTAINER_NAME}; exit"
	@echo "Creado contendor ${BACK_CONTAINER_NAME} y creando ventana para ver logs"
	@echo "Parar su ejecucion haz \"make stop-${BACK_CONTAINER_NAME}\""

#Bajar container backend
stop-backend:
	@if [ -n "$$(docker ps -q --filter "name=^/$(BACK_CONTAINER_NAME)$$")" ]; then \
		docker rm -f $(BACK_CONTAINER_NAME) > /dev/null 2>&1; \
		echo "Container $(BACK_CONTAINER_NAME) detenido y eliminado"; \
	elif [ -n "$$(docker ps -aq --filter "name=^/$(BACK_CONTAINER_NAME)$$")" ]; then \
		docker rm $(BACK_CONTAINER_NAME) > /dev/null 2>&1; \
		echo "Container $(BACK_CONTAINER_NAME) eliminado"; \
	else \
		echo "No existe ningún container $(BACK_CONTAINER_NAME)"; \
	fi

#Levantar servicio backend
backend: build-backend run-backend

#Levantar servicio backend con logs
backend-logs: build-backend run-backend-logs


##CONSTRUIR###

########################
# LOCAL DEVELOPMENT    #
########################

#frontend en local
localfront:
	cd ${FRONT_DIR} && npm ci && API_TARGET=http://localhost:8080 npm run dev -- --host 0.0.0.0 --port 5173

# Backend local
localback:
	cd ${BACKEND_DIR} && mvn package && java -jar target/backend-0.0.1-SNAPSHOT.jar

# Ambos servicios local en terminales independientes
local:
	@gnome-terminal --title="Frontend" -- bash -c '$(MAKE) localfront; exec bash'
	@gnome-terminal --title="Backend" -- bash -c '$(MAKE) localback; exec bash'


########################
# Docker compose       #
########################

# Levantar todos los servicios
up:
	@docker compose down --remove-orphans
	@echo "Limpiados los contenedores anteriores y servicios huérfanos"
	@docker compose up -d --build
	@echo "Todos los servicios levantados correctamente"
	@echo "Para ver los logs: make up-logs"
	@echo "Para detener los servicios: make down"

# Levantar todos los servicios con logs
up-logs:
	@docker compose down --remove-orphans
	@echo "Limpiados los contenedores anteriores y servicios huérfanos"
	@docker compose up -d --build && \
	gnome-terminal --title="Backend Docker Logs" -- bash -c "docker compose logs -f backend; exit" && \
	gnome-terminal --title="Frontend Docker Logs" -- bash -c "docker compose logs -f frontend; exit"
	@echo "Todos los servicios levantados y ventanas de logs abiertas"

# Bajar todos los servicios
down:
	@if [ -n "$$(docker compose ps -aq)" ]; then \
		docker compose down --remove-orphans; \
		echo "Todos los servicios detenidos y contenedores eliminados"; \
	else \
		echo "No hay contenedores en ejecucion ni detenidos"; \
	fi
