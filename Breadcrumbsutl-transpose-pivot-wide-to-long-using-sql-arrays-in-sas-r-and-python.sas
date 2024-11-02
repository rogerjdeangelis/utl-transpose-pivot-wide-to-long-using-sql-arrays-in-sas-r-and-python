%let pgm=utl-transpose-pivot-wide-to-long-using-sql-arrays-in-sas-r-and-python;

Transpose pivot wide to long using sql arrays in sas r and python

%stop_submission;

Not as slow as you might think, depends on compiler. Generally compilers like repetitive code.

github
https://tinyurl.com/zmp3dxe
https://github.com/rogerjdeangelis/utl-transpose-pivot-wide-to-long-using-sql-arrays-in-sas-r-and-python

stackoverflow sas
https://stackoverflow.com/questions/79135645/how-to-transpose-in-sas-eg-when-there-are-multiple-columns-of-differing-data-typ

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                      |                                                      |                          */
/*              INPUT                   |                  PROCESS                             |   OUTPUT                 */
/*                                      |               SELF EXPLANTORY                        |                          */
/*                                      |                                                      |                          */
/*                                      |                  HARDCODE                            |                          */
/*                                      |                                                      |                          */
/*   X1    X2    X3    Y1    Y2    Y3   |  select x1 as x ,y1 as y from sd1.have union all     |   X    Y                 */
/*                                      |  select x2 as x ,y2 as y from sd1.have union all     |                          */
/*    1     4     7    a     d     g    |  select x3 as x ,y3 as y from sd1.have               |   1    a                 */
/*    2     5     8    b     e     h    |                                                      |   2    b                 */
/*    3     6     9    c     f     i    |     WITH SQL ARRAYS (SAME CODE IN R, PYHON AND SAS)  |   3    c                 */
/*                                      |                                                      |   4    d                 */
/*                                      |   %do_over(_i,phrase=%str(                           |   5    e                 */
/*                                      |     select x? as x ,y? as y from sd1.have),          |   6    f                 */
/*                                      |       between=union all)                             |   7    g                 */
/*                                      |                                                      |   8    h                 */
/*                                      | Note: You can do custom summarization within selects |   9    i                 */
/*                                      |                                                      |   9    i                 */
/*                                      |                                                      |                          */
/***********************************************************************************************|***************************/

 SOLUTIONS

    1 sas sql
    2 r sql
    3 python sql
    4 sas loop

Related repos
https://github.com/rogerjdeangelis/utl_sql_version_of_proc_transpose_with_major_advantage_of_summarization
https://github.com/rogerjdeangelis/utl_transpose_with_proc_sql
https://github.com/rogerjdeangelis/utl-pivot-long-pivot-wide-transpose-partitioning-sql-arrays-wps-r-python
https://github.com/rogerjdeangelis/utl-pivot-long-transpose-three-arrays-of-size-three-sas-r-python-sql
https://github.com/rogerjdeangelis/utl-pivot-transpose-by-id-using-wps-r-python-sql-using-partitioning
https://github.com/rogerjdeangelis/utl-sas-proc-transpose-in-sas-r-wps-python-native-and-sql-code
https://github.com/rogerjdeangelis/utl-sas-proc-transpose-wide-to-long-in-sas-wps-r-python-native-and-sql
https://github.com/rogerjdeangelis/utl-simple-classic-transpose-pivot-wider-in-native-and-sql-wps-r-python
https://github.com/rogerjdeangelis/utl-transpose-pivot-wide-using-sql-partitioning-in-wps-r-python
https://github.com/rogerjdeangelis/utl-transposing-multiple-variables-using-transpose-macro-sql-arrays-proc-report
https://github.com/rogerjdeangelis/utl-fast-normalization-and-join-using-vvaluex-arrays-sql-hash-untranspose-macro


/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
input x1 x2 x3 y1$ y2$ y3$;
cards4;
1 4 7 a d g
2 5 8 b e h
3 6 9 c f i
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Obs    X1    X2    X3    Y1    Y2    Y3                                                                               */
/*                                                                                                                        */
/*   1      1     4     7    a     d     g                                                                                */
/*   2      2     5     8    b     e     h                                                                                */
/*   3      3     6     9    c     f     i                                                                                */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
 _                   _      |_|      _
| |__   __ _ _ __ __| | ___ ___   __| | ___
| `_ \ / _` | `__/ _` |/ __/ _ \ / _` |/ _ \
| | | | (_| | | | (_| | (_| (_) | (_| |  __/
|_| |_|\__,_|_|  \__,_|\___\___/ \__,_|\___|

*/
proc sql;
  create
    table hardcode as
  select x1 as x ,y1 as y from sd1.have union all
  select x2 as x ,y2 as y from sd1.have union all
  select x3 as x ,y3 as y from sd1.have
;quit;

/*         _
 ___  __ _| |   __ _ _ __ _ __ __ _ _   _ ___
/ __|/ _` | |  /  ` | `__| `__/ _` | | | / __|
\__ \ (_| | | | (_| | |  | | | (_| | |_| \__ \
|___/\__, |_|  \__,_|_|  |_|  \__,_|\__, |___/
        |_|                         |___/
*/

%array(_i,values=1-3)

proc sql;
  create
    table hardcode as
  %do_over(_i,phrase=%str(
    select x? as x ,y? as y from sd1.have), between=union all)
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*    X    Y                                                                                                              */
/*                                                                                                                        */
/*    1    a                                                                                                              */
/*    2    b                                                                                                              */
/*    3    c                                                                                                              */
/*    4    d                                                                                                              */
/*    5    e                                                                                                              */
/*    6    f                                                                                                              */
/*    7    g                                                                                                              */
/*    8    h                                                                                                              */
/*    9    i                                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
WITH SQL ARRAYS
*/

%array(_i,values=1-3)

* CREATE SQL CODE;

%let sql=%do_over(_i,phrase=%str(select x? as x ,y? as y from have), between=union all);
%put &=sql;

SQL=select x1 as x ,y1 as y from have union all select x2 as x ,y2 as y from have union all select x3 as x ,y3 as y from have


%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want <- sqldf("&sql")
want;
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rrwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rrwant;
run;quit;

/**************************************************************************************************************************/
/*           |                                                                                                            */
/*   R       |   SAS                                                                                                      */
/*           |                                                                                                            */
/*    x y    |   ROWNAMES    X    Y                                                                                       */
/*           |                                                                                                            */
/*  1 1 a    |       1       1    a                                                                                       */
/*  2 2 b    |       2       2    b                                                                                       */
/*  3 3 c    |       3       3    c                                                                                       */
/*  4 4 d    |       4       4    d                                                                                       */
/*  5 5 e    |       5       5    e                                                                                       */
/*  6 6 f    |       6       6    f                                                                                       */
/*  7 7 g    |       7       7    g                                                                                       */
/*  8 8 h    |       8       8    h                                                                                       */
/*  9 9 i    |       9       9    i                                                                                       */
/*           |                                                                                                            */
/**************************************************************************************************************************/

/*____               _   _                             _
|___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

%array(_i,values=1-3)

* CREATE SQL CODE;

%let sql=%do_over(_i,phrase=%str(select x? as x ,y? as y from have), between=union all);
%put &=sql;

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
have
want=pdsql("&sql")
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx(resolve=Y);
proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/* PYTHON       | SAS                                                                                                     */
/*       x  y   |    X    Y                                                                                               */
/*              |                                                                                                         */
/*  0  1.0  a   |    1    a                                                                                               */
/*  1  2.0  b   |    2    b                                                                                               */
/*  2  3.0  c   |    3    c                                                                                               */
/*  3  4.0  d   |    4    d                                                                                               */
/*  4  5.0  e   |    5    e                                                                                               */
/*  5  6.0  f   |    6    f                                                                                               */
/*  6  7.0  g   |    7    g                                                                                               */
/*  7  8.0  h   |    8    h                                                                                               */
/*  8  9.0  i   |    9    i                                                                                               */
/*              |                                                                                                         */
/**************************************************************************************************************************/

/*  _                     _
| || |    ___  __ _ ___  | | ___   ___  _ __
| || |_  / __|/ _` / __| | |/ _ \ / _ \| `_ \
|__   _| \__ \ (_| \__ \ | | (_) | (_) | |_) |
   |_|   |___/\__,_|___/ |_|\___/ \___/| .__/
                                       |_|
*/
data want;
  set sd1.have;
  array xs x1-x3;
  array ys y1-y3;
  do i = 1 to dim(xs);
    x = xs[i];
    y = ys[i];
    output;
  end;
  keep  x y;
run;

proc sort data=want out=wantsrt;
by x y;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*    X    Y                                                                                                              */
/*                                                                                                                        */
/*    1    a                                                                                                              */
/*    2    b                                                                                                              */
/*    3    c                                                                                                              */
/*    4    d                                                                                                              */
/*    5    e                                                                                                              */
/*    6    f                                                                                                              */
/*    7    g                                                                                                              */
/*    8    h                                                                                                              */
/*    9    i                                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
