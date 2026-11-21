# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anruiz-d <anruiz-d@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/11/21 17:09:47 by anruiz-d          #+#    #+#              #
#    Updated: 2026/11/21 17:35:14 by anruiz-d         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE-FRONT = docker compose -f docker-compose.yaml

front-up:
	$(COMPOSE-FRONT) up -d --build --no-deps frontend

front-down:
	$(COMPOSE-FRONT) stop frontend

front-build:
	$(COMPOSE-FRONT) build frontend

front-logs:
	$(COMPOSE-FRONT) logs -f frontend

front-clean:
	$(COMPOSE-FRONT) rm -sf frontend

front-fclean: front-clean
	@docker image rm compose-frontend:latest 2>/dev/null || true
	@docker volume rm compose_frontend_node_modules 2>/dev/null || true

front-re: front-fclean front-up

##############
##  COLORS  ##
##############

CYAN   = \033[0;36m
GREEN  = \033[0;32m
YELLOW = \033[0;33m
RESET  = \033[0m

##############
##   HELP   ##
##############

help-front:
	@printf "$(CYAN)\n=================== HELP FRONTEND ======================$(RESET)\n"
	@printf "  $(GREEN)%-18s$(RESET) %s\n" "make front-up" "Start the frontend container"
	@printf "  $(GREEN)%-18s$(RESET) %s\n" "make front-down" "Stop the frontend container"
	@printf "  $(GREEN)%-18s$(RESET) %s\n" "make front-build" "Build the frontend image"
	@printf "  $(GREEN)%-18s$(RESET) %s\n" "make front-logs" "Show frontend container logs"
	@printf "  $(YELLOW)%-18s$(RESET) %s\n" "make front-clean" "Remove the frontend container"
	@printf "  $(YELLOW)%-18s$(RESET) %s\n" "make front-fclean" "Remove container, image and volume"
	@printf "  $(YELLOW)%-18s$(RESET) %s\n" "make front-re" "Clean and rebuild the frontend"
	@printf "  $(GREEN)%-18s$(RESET) %s\n" "make help-front" "Display this help message"
	@printf "$(CYAN)========================================================$(RESET)\n\n"

.PHONY: front-up front-down front-build front-logs front-clean front-fclean front-re help-front



