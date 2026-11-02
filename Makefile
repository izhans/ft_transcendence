# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: anruiz-d <anruiz-d@student.42madrid.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/11/02 15:52:55 by anruiz-d          #+#    #+#              #
#    Updated: 2026/11/02 20:57:22 by anruiz-d         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f compose/compose.dev.yaml

front-up:
	$(COMPOSE) up -d --build --no-deps frontend

front-down:
	$(COMPOSE) stop frontend

front-build:
	$(COMPOSE) build frontend

front-logs:
	$(COMPOSE) logs -f frontend

front-clean:
	$(COMPOSE) rm -sf frontend

front-fclean: front-clean
	@docker image rm compose-frontend:latest 2>/dev/null || true
	@docker volume rm compose_frontend_node_modules 2>/dev/null || true

front-re: fclean all

.PHONY: all front-up front-down front-build front-logs front-clean front-fclean front-re
