/*
 * Project    : ipv6calc
 * File       : ipv6calchelp.h
 * Version    : $Id: ipv6calchelp.h,v 1.1 2002/03/02 22:06:53 peter Exp $
 * Copyright  : 2002 by Peter Bieringer <pb (at) bieringer.de>
 *
 * Information:
 *  Header file for ipv6calchelp.c
 */

extern void printhelp_print(void);
extern void printhelp_mask(void);
extern void printhelp_case(void);
extern void printhelp_printstartend(void);

extern void printversion(void);
extern void printcopyright(void);
extern void printinfo(void);

extern void printhelp_doublecommands(void);
extern void printhelp_missinginputdata(void);
extern void printhelp_inputtypes(void);
extern void printhelp_outputtypes(long int inputtype);
extern void printhelp(void);
extern void printhelp_output_dispatcher(long int outputtype);
