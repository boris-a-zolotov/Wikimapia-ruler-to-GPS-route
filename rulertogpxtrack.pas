program rulertogps;

const p = 10000000; const tab = '    ';
var r, frame1, frame2 : int64;
	coord : array [1..50000, 1..2] of int64;
	n, i : longint;
	trkName, fileName : String; symb : char;

(* * * * * * * *)

begin;
write('Insert title (Eng letters only): '); readln(trkName);
fileName := trkName + '.gpx';

assign(output,fileName);
rewrite(output);

assign(input,'in-hat.txt');
reset(input);
	repeat read(symb); write(symb) until eof;
close(input);

assign(input,'in-coord.txt');
reset(input);

n := 0; read(frame2, frame1);
repeat
	n := n+1;
	read (r); coord[n,2] := r + frame2;
	read (r); coord[n,1] := r + frame1;
until eof;

writeln; writeln; writeln;
writeln(tab, '<trk> <name>', trkName, '</name>');
writeln(tab, '<desc>- - - - - - - -</desc>');

for i:=1 to n do begin;
	writeln(tab, tab,
		'<trkpt lat="',
		(coord[i,1] / p):3:8,
		'" lon="',
		(coord[i,2] / p):3:8,
		'"> </trkpt>');
end;

writeln(tab, '</trk>');
writeln('</gpx>');
close(input); close(output);
end.