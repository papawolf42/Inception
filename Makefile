# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gunkim <gunkim@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/11 22:17:00 by gunkim            #+#    #+#              #
#    Updated: 2022/08/13 21:46:57 by gunkim           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env

# color
YELLOW = "\033[33m"
END_COL = "\033[39m"

NAME		:= inception
SRCS		:= srcs
DIR_VOLUME	:= $(PATH_HOST_VOL_MARIADB) $(PATH_HOST_VOL_WORDPRESS)



.PHONY: all clean fclean re

all : $(NAME)

$(NAME) : $(DIR_VOLUME)
	docker compose -f $(SRCS)/docker-compose.yaml up -d --build

$(PATH_HOST_VOL_MARIADB) :
	mkdir -p $(PATH_HOST_VOL_MARIADB)

$(PATH_HOST_VOL_WORDPRESS) :
	mkdir -p $(PATH_HOST_VOL_WORDPRESS)

clean:
	docker compose -f $(SRCS)/docker-compose.yaml down

fclean:
	docker compose -f $(SRCS)/docker-compose.yaml down --rmi all
	docker volume rm vol_mariadb
	docker volume rm vol_wordpress

re: fclean all


.PHONY: ls

ls :
	@echo $(YELLOW)"[docker ps -a]"$(END_COL)
	@docker ps -a
	@echo $(YELLOW)"\n[docker images]"$(END_COL)
	@docker images ls
	@echo $(YELLOW)"\n[image list]"$(END_COL)
	@docker image ls
	@echo $(YELLOW)"\n[volume list]"$(END_COL)
	@docker volume ls
	@echo $(YELLOW)"\n[network list]"$(END_COL)
	@docker network ls
