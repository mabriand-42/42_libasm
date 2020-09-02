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

void	ft_print_list(t_list *list)
{
	if (list == NULL)
			printf("(null)\n");
	while (list)
	{
		printf("; '%s' | ptr_data = %p | ptr_next = %p\n", (char *)list->data, list, list->next);
		list = list->next;
	}
}

void	ft_list_clear(t_list *list)
{
	t_list *tmp;

	tmp = NULL;
	while (list)
	{
		tmp = list->next;
		free(list->data);
		free(list);
		list = tmp;
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

	t_list	*list;

	list = NULL;
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("%ssize = %d\n\n%s", BWHITE, ft_list_size(list), NC);

	printf("%safter:%s\n", BWHITE, NC);
	ft_list_push_front(&list, strdup("Huafaef"));
	ft_list_push_front(&list, strdup("fzgrhh"));
	ft_list_push_front(&list, strdup("gre0vre84"));
	ft_list_push_front(&list, strdup("pofeiajfK"));
	ft_print_list(list);
	printf("%ssize = %d\n%s", BWHITE, ft_list_size(list), NC);
	
	ft_list_push_front(&list, strdup("kzoidhz"));
	printf("\n%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)list->data, list, list->next);
	ft_list_push_front(&list, NULL);
	printf("%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)list->data, list, list->next);
	ft_list_push_front(&list, strdup("XZAmlkdk"));
	printf("%sadded:%s `%s` | ptr_data = %p | ptr_next = %p\n", BWHITE, NC, (char *)list->data, list, list->next);
	ft_print_list(list);
	printf("%ssize = %d\n%s", BWHITE, ft_list_size(list), NC);

	ft_list_clear(list);

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
	ft_list_push_front(&list, strdup("hIOA"));
	ft_list_push_front(&list, strdup("anoczr"));
	ft_list_push_front(&list, strdup("whuaigf"));
	ft_list_push_front(&list, strdup("pczkz"));
	ft_list_push_front(&list, strdup("abiuceh"));
	ft_list_push_front(&list, strdup("zhduid"));
	ft_list_push_front(&list, strdup("uu"));
	ft_list_push_front(&list, strdup("ftegd"));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("\n");

	ft_list_remove_if(&list, "uu", strcmp, free);

	printf("%safter:%s\n", BWHITE, NC);
	ft_print_list(list);
	ft_list_clear(list);
	printf("\n");

	list = NULL;
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("2"));
	ft_list_push_front(&list, strdup("5"));
	ft_list_push_front(&list, strdup("2"));
	ft_list_push_front(&list, strdup("8"));
	ft_list_push_front(&list, strdup("0"));
	ft_list_push_front(&list, strdup("0"));
	ft_list_push_front(&list, strdup("1"));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	printf("\n");

	//ft_list_remove_if(&list, "5", strcmp, free);

	printf("%safter:%s\n", BWHITE, NC);
	ft_print_list(list);
	ft_list_clear(list);

	printf("\n%s===> Done!%s\n\n", BGREEN, NC);
	return ;
}

/*
** ft_list_sort
*/

void	ft_check_list_sort(void)
{
	printf("\n\n%s*********************** FT_LIST_SORT ***************\n\n%s", UCYAN, NC);

	t_list	*list;

	list = NULL;
	ft_list_push_front(&list, strdup("Hfiozet"));
	ft_list_push_front(&list, strdup("Lfiaj"));
	ft_list_push_front(&list, strdup("Rkjfn"));
	ft_list_push_front(&list, strdup("ZAOIFUfu"));
	ft_list_push_front(&list, strdup("01728"));
	ft_list_push_front(&list, strdup("aji"));
	ft_list_push_front(&list, strdup("POifa2"));
	ft_list_push_front(&list, strdup("zzzzzzzzzzzz"));
	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);

	printf("\n%safter:%s\n", BWHITE, NC);
	ft_list_sort(&list, &strcmp);
	ft_print_list(list);
	
	ft_list_clear(list);

	printf("\n\n%ssort with begin_list = NULL:%s\n", BCYAN, NC);

	list = NULL;
	ft_list_push_front(&list, strdup("HAdud"));
	ft_list_push_front(&list, strdup("0fzpjv47"));
	ft_list_push_front(&list, strdup("cnoiufe"));

	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	ft_list_sort(NULL, &strcmp);
	printf("\n%safter:%s\n", BWHITE, NC);
	ft_print_list(list);

	printf("\n%ssort with begin_list = &list:%s\n", BCYAN, NC);

	printf("%sbefore:%s\n", BWHITE, NC);
	ft_print_list(list);
	ft_list_sort(&list, &strcmp);
	printf("\n%safter:%s\n", BWHITE, NC);
	ft_print_list(list);

	ft_list_clear(list);

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