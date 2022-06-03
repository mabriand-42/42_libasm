# Libasm #

[![mabriand's 42 libasm Score](https://badge42.vercel.app/api/v2/cl3y8m48b020709mm5fyc36fq/project/1937631)](https://github.com/JaeSeoKim/badge42)

***Your very first own library***

> The aim of this project is to get familiar with assembly language.
> An assembly (or assembler) language, often abbreviated asm, is a low-level programming language for a computer, or  
other programmable device, in which there is a very strong (but often not one-to-one) correspondence between the  
language and the architecture’s machine code instructions. Each assembly language is specific to a particular computer
architecture. In contrast, most high-level programming languages are generally portable across multiple architectures
but require interpreting or compiling. Assembly language may also be called symbolic machine code.

## Description ##

The objective of this project is to create a static library (.a file).  
It is actually just an archive of the original .o files, made with the `ar` command (a precedessor
of `tar` now just used to make libraries).

<!-- ## Visuals ## -->

## Installation ##

`$ git clone https://github.com/mariebriand/42-CC_Libasm.git` </br>
`$ cd 42-CC_Libasm` </br>
`$ make` / `$ make bonus` </br> for the mandatory / bonus part.

You will then end up with a static library for both.

## Usage ##

`$ gcc -Wall -Werror -Wextra [main/main_bonus].c libasm.a -no-pie` </br>
`$ ./a.out`

<!-- ## Support ## -->

## Roadmap ##

* Check for the right license (and document myself about open source licenses).
* Add a way to reach me for support.
* Add the official subject from 42intra.

<!-- ## Contributing ## -->

<!-- ## Authors and acknowledgement ## -->

<!-- ## License ## -->

## Project status ##

This project is finished, it has passed the 3 needed peer-corrections.

[![forthebadge](https://forthebadge.com/images/badges/made-with-c.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/open-source.svg)](https://forthebadge.com)