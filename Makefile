# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mabriand <mabriand@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/20 13:11:26 by vmoreau           #+#    #+#              #
#    Updated: 2022/06/03 12:29:52 by mabriand         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

##################################### PATH #####################################

NATIV = src/native/
BONUS = src/bonus/

#################################### SOURCES ###################################

SRCS +=	$(NATIV)ft_strlen.s		$(NATIV)ft_strcpy.s		$(NATIV)ft_strcmp.s \
		$(NATIV)ft_strdup.s		$(NATIV)ft_read.s		$(NATIV)ft_write.s 

SRCSBO += 	$(BONUS)ft_list_push_front_bonus.s 	$(BONUS)ft_list_size_bonus.s \
			$(BONUS)ft_list_remove_if_bonus.s 	$(BONUS)ft_atoi_base_bonus.s \
			$(BONUS)ft_list_sort_bonus.s

##################################### BASIC ####################################

CFLAGS 	= -Wall -Wextra -Werror

CC = gcc

INC = inc/

HEADER = $(INC)libasm.h

OBJS = $(SRCS:.s=.o)

OBJSBO = $(SRCSBO:.s=.o)

EXE = exe

EXEBO = exebo

#################################### RULES ####################################

all : $(NAME)

.s.o:
	@nasm -f elf64 $^

$(NAME) : $(OBJS) 
	@ar rcs $(NAME) $(OBJS)

run : $(NAME)
	@$(CC) -no-pie $(CFLAGS) main.c -L ./ -lasm -o $(EXE)
	@./exe

bonus : $(OBJS) $(OBJSBO) 
	@ar rcs $(NAME) $(OBJS) $(OBJSBO)

run_bonus : bonus $(NAME)
	@$(CC) -no-pie $(CFLAGS) main_bonus.c -L ./ -lasm -o $(EXEBO)
	@./exebo

clean :
	@$(RM) -rf $(NAME)
	@$(RM) -rf $(OBJS)
	@$(RM) -rf $(OBJSBO)

fclean : clean
	@$(RM) exe
	@$(RM) exebo

re : fclean all

.PHONY : all clean fclean re
.SILENT :
