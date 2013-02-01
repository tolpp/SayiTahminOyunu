/*

Sayý Dizisi Tahmini Oyunu
Oyuncu : Ýnsan

Ahmet Tolga Okur
05-09-23

Programi run. komutu ile calistirin ve tahmininizi [X,Y,Z,T]. seklinde girin.
SWI-Prolog ile test edilmistir.

*/

clear :- format('~c~s~c~s',[0x1b,"[H",0x1b,"[2J"]).

:- dynamic
        cozum/1, % Bilgisayar tarafindan uretilen random dizi
        sayi/1. % Kullanýcýnýn her adimda girdigi deger

/* ********************** OYUN ************************* */
run:-
    basla.

basla:- %Oyunu baslatan procedure
	clear,
	retractall(cozum(_)),
	randomListGenerator(4,1,9,Random),
	assert(cozum(Random)),
	oyna,
	write('\n'),write('Cozumunuz dogru, tebrikler').
sayiAl:-
	write('Diziyi Girin : '),
	read(A),
	assert(sayi(A)).
sayiYaz:-
	sayi(X),
	write(X),
	cozum(C),
	icermeSayisi(X,C,R),
	eslesmeSayisi(X,C,E),
	write('--> Icerme : '),write(R),
	write(' Eslesme :'),write(E),write('\n'),
	fail.
sayiYaz.
oyna:-
	not(cozumKontrol),
	retractall(sayi(_)),
	sayiAl,
	sayiYaz,
	oyna,
	fail.
oyna:-
	cozumKontrol,
	fail.
oyna.

icermeSayisi([],_,0). % Bir listede diger listedeki elemanlardan kac tane bulundugu

icermeSayisi([H|T],List2,R):-
        icermeSayisi(T,List2,R2),
        memberchk(H,List2),
        R is R2 + 1.

icermeSayisi([H|T],List2,R):-
        icermeSayisi(T,List2,R2),
        not(memberchk(H,List2)),
        R is R2.


eslesmeSayisi([],[],0). % Iki listede tam olarak eslesen sayilarin sayisi

eslesmeSayisi([H|T],[B|S],R):-
        eslesmeSayisi(T,S,R2),
        esitMi(H,B),
        R is R2 + 1.

eslesmeSayisi([H|T],[B|S],R):-
        eslesmeSayisi(T,S,R2),
        not(esitMi(H,B)),
        R is R2.

esitMi(S1,S2):- % Iki degerin esitlik kontrolu
        S1 = S2.

lengthOf([], 0). % Liste uzunlugu
        lengthOf([_|T], L):-
            lengthOf(T, TailLength),
            L is TailLength + 1.

cozumKontrol:- % Cozumun dogrulugunun kontrolu
    cozum(X),
    sayi(Y),
    eslesmeSayisi(X,Y,C),
    lengthOf(X,L),
    C = L.

% Cozum'un random olarak olusturulmas,
randomListGenerator(ListSize,Start,End,RandomList):-
	Dif is End - Start + 1,
	Operation is Start - 1,
	randseq(ListSize,Dif,TempList),
	placeList(TempList,Operation,RandomList).

% Istenen degerin listede istenilen noktaya eklenmesi
placeList([],_,[]).
placeList([H|T],Op,[L|R]):-
	placeList(T,Op,R),
	L is H + Op.
	
