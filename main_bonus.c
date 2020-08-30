/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mabriand <mabriand@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/03/09 11:01:23 by mabriand          #+#    #+#             */
/*   Updated: 2020/03/10 15:10:28 by mabriand         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_header/libasm_bonus.h"


/*
** Useful macro
*/

# define ATOI_BASE(s, b)	i = ft_atoi_base(s, b); printf("\'%s'   [%s] = %s%d%s\n", s, b, BGREEN, i, NC);

/*
** Useful functions
*/

t_list	*list_new(void *data)
{
	t_list		*lst;

	if (!(lst = malloc(sizeof(t_list))))
		return (NULL);
	lst->data = data;
	lst->next = NULL;
	return (lst);
}

void	list_add_back(t_list **alst, t_list *new)
{
	t_list	*tmp;

	if (!alst || !new)
		return ;
	if (*alst)
	{
		tmp = *alst;
		while (tmp->next)
			tmp = tmp->next;
		tmp->next = new;
	}
	else
		*alst = new;
}

void	ft_lstclear(t_list **list)
{
	t_list	*tmp;

	while (*list)
	{
		tmp = (*list)->next;
		if ((*list)->data)
			free((*list)->data);
		if (*list)
		{
			free(*list);
			*list = tmp;
		}
	}
}

void	ft_print_list(t_list *list)
{
	while (list)
	{
		printf("; '%s' | ptr_data = %p | ptr_next = %p\n", (char *)list->data, list, list->next);
		list = list->next;
	}
}

/*
** ft_atoi_base
*/

void	ft_check_atoi_base(void)
{
	printf("%s\n\n*********************** FT_ATOI_BASE ********************\n\n%s", UCYAN, NC);
	int	i = 0;

	ATOI_BASE("42", "0123456789")
	ATOI_BASE("0", "0123456789")
	ATOI_BASE("1", "0123456789")
	ATOI_BASE("1215415478", "0123456789")
	ATOI_BASE("-0", "0123456789")
	ATOI_BASE("-1", "0123456789")
	ATOI_BASE("-42", "0123456789")
	ATOI_BASE("--42", "0123456789")
	ATOI_BASE("-+-42", "0123456789")
	ATOI_BASE("-+-+-+42", "0123456789")
	ATOI_BASE("-+-+-+-42", "0123456789")
	ATOI_BASE("-1215415478", "0123456789")
	ATOI_BASE("2147483647", "0123456789")
	ATOI_BASE("2147483648", "0123456789")
	ATOI_BASE("-2147483648", "0123456789")
	ATOI_BASE("-2147483649", "0123456789")
	ATOI_BASE("2a", "0123456789abcdef")
	ATOI_BASE("ff", "0123456789abcdef")
	ATOI_BASE("poney", "poney")
	ATOI_BASE("dommage", "invalid")
	ATOI_BASE("dommage", "aussi invalide")
	ATOI_BASE("dommage", "+toujours")
	ATOI_BASE("dommage", "-stop")
	ATOI_BASE("dommage", "  \t\nca suffit")
	ATOI_BASE("    +42", "0123456789")
	ATOI_BASE("    -42", "0123456789")
	ATOI_BASE("    42", "0123456789")
	ATOI_BASE("  \t\n\r\v\f  42", "0123456789")
	ATOI_BASE("  \t\n\r\v\f  -42", "0123456789")
	ATOI_BASE("42FINIS !", "0123456789")
	ATOI_BASE("-42FINIS !", "0123456789")
	ATOI_BASE("C'est dommage42", "0123456789")

	printf("\n%s===> Done!%s", BGREEN, NC);
	return ;
}

/*
** ft_list_size
*/

void	ft_check_list_size(void)
{
	printf("\n\n%s*********************** FT_LIST_SIZE ********************\n\n%s", UCYAN, NC);

	t_list	list;
	t_list	list_next;
	t_list	list_last;

	list.data = strdup("Hello");
	list.next = &list_next;
	list_next.data = strdup("Salut");
	list_next.next = &list_last;
	list_last.data = strdup("Bonjour");
	list_last.next = NULL;

	printf("%slist content:\n\n%s", BWHITE, NC);
	ft_print_list(&list);

	printf("\n");
	printf("from %sfirst%s, size = %s%d%s\n", BWHITE, NC, BGREEN, ft_list_size(&list), NC);
	printf("from %ssecond%s, size = %s%d%s\n", BWHITE, NC, BGREEN, ft_list_size(&list_next), NC);
	printf("from %slast%s, size = %s%d%s\n", BWHITE, NC, BGREEN, ft_list_size(&list_last), NC);
	printf("from %s(null)%s, size = %s%d%s\n", BWHITE, NC, BGREEN, ft_list_size(NULL), NC);
	
	printf("\n%s===> Done!%s", BGREEN, NC);

	free(list.data);
	free(list_next.data);
	free(list_last.data);
	return ;
}

/*
** ft_list_push_front
*/

void	ft_check_list_push_front(void)
{
	printf("\n\n%s*********************** FT_LIST_PUSH_FRONT **************\n\n%s", UCYAN, NC);

	t_list	list;
	t_list	list_next;
	t_list	list_last;
	t_list	*push_test;

	list.data = strdup("Hello");
	list.next = &list_next;
	list_next.data = strdup("Salut");
	list_next.next = &list_last;
	list_last.data = strdup("Bonjour");
	list_last.next = NULL;
	push_test = &list;

	printf("%slist content:\n\n%s", BWHITE, NC);
	ft_print_list(&list);

	ft_list_push_front(&push_test, strdup("Coucou"));

	printf("\n%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)push_test->data, push_test, push_test->next);
	printf("%snew size = %d\n%s", BWHITE, ft_list_size(push_test), NC);
	
	free(list.data);
	free(push_test->data);
	free(push_test);
	
	push_test = NULL;

	ft_list_push_front(&push_test, strdup("Good morning"));
	printf("\n%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)push_test->data, push_test, push_test->next);
	ft_list_push_front(&push_test, NULL);
	printf("%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)push_test->data, push_test, push_test->next);
	
	free(push_test->next);
	push_test->next = NULL;
	
	ft_list_push_front(&push_test, strdup("Guten tag"));
	printf("%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)push_test->data, push_test, push_test->next);
	
	ft_lstclear(&push_test);
	printf("\n%s===> Done!%s", BGREEN, NC);
	return ;
}

/*
** ft_list_remove_if
*/

void	ft_check_list_remove_if(void)
{
	printf("\n\n%s*********************** FT_LIST_REMOVE_IF ***************\n\n%s", UCYAN, NC);
	t_list	*list;

	list = NULL;
	list_add_back(&list, list_new("hIOA"));
	list_add_back(&list, list_new("anoczr"));
	list_add_back(&list, list_new("whuaigf"));
	list_add_back(&list, list_new("pczkz"));
	list_add_back(&list, list_new("abiuceh"));
	list_add_back(&list, list_new("zhduid"));
	list_add_back(&list, list_new("uu"));
	list_add_back(&list, list_new("ftegd"));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("\n");

	ft_list_remove_if(&list, "uu", strcmp, free);

	printf("%safter:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("\n");

	list = NULL;
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("2")));
	list_add_back(&list, list_new(strdup("5")));
	list_add_back(&list, list_new(strdup("2")));
	list_add_back(&list, list_new(strdup("8")));
	list_add_back(&list, list_new(strdup("0")));
	list_add_back(&list, list_new(strdup("0")));
	list_add_back(&list, list_new(strdup("1")));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("\n");

	ft_list_remove_if(&list, "5", strcmp, free);

	printf("%safter:%s\n", BWHITE, NC);
	ft_print_list(list);

	printf("\n%s===> Done!%s\n\n", BGREEN, NC);
	return ;
}

/*
** ft_list_sort
*/

void	ft_check_list_sort(void)
{
	printf("\n\n%s*********************** FT_LIST_SORT ***************\n\n%s", UCYAN, NC);

	t_list	list;
	t_list	list_next;
	t_list	list_last;
	t_list	*push_test1;
	t_list	*push_test2;

	list.data = strdup("Hfiozet");
	list.next = &list_next;
	list_next.data = strdup("Lfiaj");
	list_next.next = &list_last;
	list_last.data = strdup("Rkjfn");
	list_last.next = NULL;
	push_test1 = &list;
	
	ft_list_push_front(&push_test1, strdup("Zaoifu"));
	ft_list_push_front(&push_test1, strdup("mdjiozef"));
	ft_list_push_front(&push_test1, strdup("0123456"));
	ft_list_push_front(&push_test1, strdup("ajiuo"));
	ft_list_push_front(&push_test1, strdup("Roooooom"));
	ft_list_push_front(&push_test1, strdup("vsyiqUU"));
	ft_list_push_front(&push_test1, strdup("POifa2"));
	ft_list_push_front(&push_test1, strdup("ZUIHDJQQS"));
	ft_list_push_front(&push_test1, strdup("798456"));
	ft_list_push_front(&push_test1, strdup("0"));
	ft_list_push_front(&push_test1, strdup("zzzzzzzzzzzz"));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(push_test1);
	ft_list_sort(&push_test1, &strcmp);
	printf("\n%safter:%s\n", BWHITE, NC);
	ft_print_list(push_test1);
	
	push_test2 = &list;
	printf("\n%ssort with begin_list = NULL:%s\n", BWHITE, NC);

	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(push_test2);
	ft_list_sort(NULL, &strcmp);
	printf("\n%safter:%s\n", BWHITE, NC);
	ft_print_list(push_test2);

	printf("\n%ssort with begin_list = &list:%s\n", BWHITE, NC);

	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(push_test2);
	ft_list_sort(&push_test2, &strcmp);
	printf("\n%safter:%s\n", BWHITE, NC);
	ft_print_list(push_test2);

	printf("\n%s===> Done!%s\n\n", BGREEN, NC);
	return ;
}

int		main(void)
{
	ft_check_atoi_base();
	ft_check_list_push_front();
	ft_check_list_remove_if();
	ft_check_list_size();
	ft_check_list_sort();
	return (0);
}