main(Table) :- 
  readFile('in', Chars),
  freq(Chars, Freqs),
  isort(Freqs, Sorted),
  huffman(Sorted, Tree),
  table(Tree, Table).


table(node(nil, [A, _], nil), [[A, []]]).
  
table(N, T) :-
  node(L, _, R) = N,
  table(L, TL),
  table(R, TR),
  updateTable(TL, 0, UL),
  updateTable(TR, 1, UR),
  append(UL, UR, T).


updateTable([], _, []).

updateTable([[A,P]|Es], C, [[A, [C|P]]|X]) :-
  updateTable(Es, C, X).


huffman([X|[]], X).

huffman([N1, N2|L], Tree) :-
  node(_, [_,X], _) = N1,
  node(_, [_,Y], _) = N2,
  Freq is X + Y,
  insert(node(N1, [nil, Freq], N2), L, R),
  huffman(R, Tree).

isort([], []).

isort([E|Es], R) :-
  isort(Es, X),
  insert(E, X, R).
  
insert(X, [], [X]).

insert(X, [N|Ns], [X,N|Ns]) :-
  node(_,[_, Freq1],_) = X,
  node(_,[_, Freq2],_) = N,
  Freq1 < Freq2.

insert(X, [N|Ns], [N|R]) :-
  insert(X, Ns, R).

freq([_], []).

freq([C|[]], [node(nil, [C, 1], nil)]).

freq([C|Cs], [node(nil, [C, 1], nil)|X]) :-
  freq(Cs, X),
  not(membro(C, X)).

freq([C|Cs], X) :-
  freq(Cs, R),
  getfreq(C, R, Freq),
  Freq2 is Freq + 1,
  updatefreq(C, Freq2, R, X).

membro(E, [node(nil, [E,_], nil)|_]).

membro(E, [_|X]) :-
  membro(E, X).

getfreq(C, [node(nil,[C, X],nil)|_], X).

getfreq(C, [_|Xs], X) :-
  getfreq(C, Xs, X).

updatefreq(C, Freq, [node(nil, [C, _], nil)|X], [node(nil,[C, Freq],nil)|X]).

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
