main(Sorted) :- 
  readFile('in', Chars),
  freq(Chars, Freqs),
  isort(Freqs, Sorted).

isort(L, R) :-
  isort(L, [],R)
  

isort([], _, L).

isort([F|Fs], ).

getmenor(L, R):-

freq([], []).

freq([C|[]], [[C, 1]]).

freq([C|Cs], [[C, 1]|X]) :-
  freq(Cs, X),
  not(membro(C, X)).

freq([C|Cs], X) :-
  freq(Cs, R),
  getfreq(C, R, Freq),
  Freq2 is Freq + 1,
  updatefreq(C, Freq2, R, X).

membro(E, [[E,_]|_]).

membro(E, [_|X]) :-
  membro(E, X).

getfreq(C, [[C, X]|_], X).

getfreq(C, [_|Xs], X) :-
  getfreq(C, Xs, X).

updatefreq(C, Freq, [[C, _]|X], [[C, Freq]|X]).

updatefreq(C, Freq, [E|Es], [E|X]) :-
  updatefreq(C, Freq, Es, X).

readFile(X, Lines):-
    open(X, read, File),
    read_lines(File, Lines),
    close(File).

read_lines(File,[]):- 
    at_end_of_stream(File).

read_lines(File,[X|L]):-
    \+ at_end_of_stream(File),
    get_char(File,X),
    read_lines(File,L).
