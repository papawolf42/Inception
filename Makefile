# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gunkim <gunkim@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/11 22:17:00 by gunkim            #+#    #+#              #
#    Updated: 2022/08/12 09:29:17 by gunkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env

# color
YELLOW = "\033[33m"
END_COL = "\033[39m"

NAME		:= inception
SRCS		:= srcs
DIR_VOLUME	:= $(PATH_HOST_VOL_MARIADB)

.PHONY: all clean fclean

all : $(NAME)

$(NAME) : $(DIR_VOLUME)
	docker compose -f $(SRCS)/docker-compose.yaml up -d --build

$(PATH_HOST_VOL_MARIADB) :
	mkdir -p $(PATH_HOST_VOL_MARIADB)

clean:
	docker compose -f $(SRCS)/docker-compose.yaml down

fclean:
	docker compose -f $(SRCS)/docker-compose.yaml down --rmi all
	docker volume rm vol_mariadb

.PHONY: ls

ls :
	@echo $(YELLOW)"[docker ps -a]"$(END_COL)
	@docker ps -a
	@echo $(YELLOW)"\n[docker images]"$(END_COL)
	@docker images ls

