/* cointoss.i */
%module cointoss
%{
extern void message();
extern int cointoss(int n);
%}

extern void message();
extern int cointoss(int n);