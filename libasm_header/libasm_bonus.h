/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h     	                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabriand <mabriand@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/07/24 17:27:21 by mabriand          #+#    #+#             */
/*   Updated: 2020/10/09 10:47:38 by mabriand         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
#define LIBASM_BONUS_H

#include "libasm.h"
/*
** Structures
*/
typedef struct	s_list
{
	void			*data;
	struct s_list	*next;
}				t_list;
/*
** Prototypes
*/
int		ft_atoi_base(const char *str,const char *base);
void	ft_list_push_front(t_list **begin_list, void *data);
int		ft_list_size(t_list *begin_list);
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));
void	ft_list_sort(t_list **begin_list,int (*cmp)());

#endif