"PLANETFALL for
			       PLANETFALL
	  (c) COPYRIGHT 1983 INFOCOM INC. ALL RIGHTS RESERVED"

<GC 0 T 5>
<BLOAT 90000 0 0 3500 0 0 0 0 0 512>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !\= !,WBREAKS>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<PRINC "Planetfall

">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<IFILE "SYNTAX" T>
<ENDLOAD>
<IFILE "MISC" T>
<IFILE "GLOBALS" T>
<IFILE "PARSER" T>
<IFILE "VERBS" T>
<IFILE "COMPONE" T>
<IFILE "COMPTWO" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

<IMAGE 7><IMAGE 7><IMAGE 7>