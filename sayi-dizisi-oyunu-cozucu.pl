/*

Say� Dizisi Tahmini Oyunu
Yonetici : Insan
Oyuncu : Bilgisayar

Ahmet Tolga Okur

Programi run. komutu ile calistirin ve bilgisayar�n tahmininin ne kadar dogru oldugunu [IcermeSayisi,EslesmeSayisi]. seklinde girin.
SWI-Prolog ile test edilmistir.

*/

clear :- format('~c~s~c~s',[0x1b,"[H",0x1b,"[2J"]).

:- dynamic
        kontrol/1,
		kesisim/1,
		temp/1.

dlist([1,2,3,4,5,6,7,8,9]). % Sayi dizileri icerisinde kullanilacak sayilar
dcount(4). % Tahmin edilecek sayi dizisinin kac adet sayidan olusacagi

run :-
	clear,
	basla.

basla:-
	write('Merhaba, ben sayi dizisi cozucu. \n'),
	initialize,
	write('Tahmin ettigim degerin icerme ve eslesme degerlerini sirayla [I,E]. seklinde giriniz.\n\n'),
	not(oyna).

oyna:-
	tahmin(Tahmin),
	write('Tahminim : '),write(Tahmin),write(', I/E? :'),
	read(IE),
	nth0(0, IE, I),
	nth0(1, IE, E),
	not(bitisKontrol(E)),
	eslesmeBul(Tahmin,I,E),
	tempToKesisim,
	oyna.

bitisKontrol(E) :-
	dcount(C),
	C = E,
	write('Cozume ulastigimi dusunuyorum.\nUmarim kolayca ulasmisimdir :)').
	!.
/*
Kesisim kumesini tum olasi degerlerle dolduran fonksiyon
*/
initialize :-
	all_d_permutation(Perm),
	asserta(kesisim(Perm)),fail.
initialize.

/*
Bilgisayar tarafindan yeni tahmin olusturulmasi kesisim listesindeki ilk eleman alinarak yapilir.
Bu fonksiyon degistirilerek random sayi secmesi ya da heuristic kullan�m� saglanabilir.
*/
tahmin(R):-
	kesisim(R),!.

/*
dlist icerisindeki tum sayilarin permutasyonu.
Bu fonksiyon olas� tum durumlari yaratir. Bos kumeler ve tum N elemanli listeler buna dahildir.
*/
permutation(L) :-
	dlist(X),
	permutation(X,L).
	
/*
Girilecek sayi dizisi uzunluguna esit uzunluktaki alt kumelerin permutasyonu
*/
all_d_permutation(Out) :-
    dlist(InList),
    subset_perm(N,InList,Out),
    dcount(N).

/*
N elemanli alt kumelerin parmutasyonu
*/
subset_perm(N, InList, Out) :-
    splitSet(InList,_,SubList),
    permutation(SubList,Out),
    length(Out, N).
/*
Bir listenin N elemanli ve sirali alt listeleri
*/
subset(N,InList,Out) :-
	splitSet(InList,_,Out),
	length(Out,N).
/*
Listeleri bolen fonksiyon
*/
splitSet([ ],[ ],[ ]).
splitSet([H|T],[H|L],R) :-
    splitSet(T,L,R).
splitSet([H|T],L,[H|R]) :-
    splitSet(T,L,R).

/*
Onceki kesisim kumesi ile yeni girilen degerden gelen eslesmeler
*/
eslesmeBul(List,Icerme,Eslesme) :-
	retractall(temp(_)),
	eslesmePerm(List,Icerme,Eslesme,0,R1),
	kesisim(R2),
	R1 = R2,
	asserta(temp(R1)),fail.
eslesmeBul(List,Icerme,Eslesme).

/*
Temp'e atilmis sayi dizilerinin kesisim'e tasinmasi
*/
tempToKesisim:-
	retractall(kesisim(_)),
	temp(R),
	asserta(kesisim(R)),fail.
tempToKesisim.

/*Test amacli kullanilan fonksiyon*/
/*
oyun(List,Icerme,Eslesme,R):-
	eslesmeBul(List,Icerme,Eslesme),
	tempToKesisim,
	kesisim(R).
*/

/*
Iki liste arasindaki tam eslesen sayilar kullanilarak olasi dizilerin olusturulmasi
*/
eslesmePerm(MyList,Icerme,Eslesme,Index,R) :-
	Eslesme > 0,
	length(MyList,Length),
	Index < Length,
	nth0(Index, MyList, Element, SubList),
	I2 is Icerme - 1,
	E2 is Eslesme - 1,
	eslesmePerm(SubList,I2,E2,Index,R2),
	nth0(Index, R, Element, R2),
	not(member(Element,R2)).

eslesmePerm(MyList,Icerme,Eslesme,Index,R) :-
	Eslesme > 0,
	length(MyList,Length),
	Index < Length,
	nth0(Index, MyList, Element),
	I2 is Index + 1,
	eslesmePerm(MyList,Icerme,Eslesme,I2,R).
	
eslesmePerm(MyList,Icerme,Eslesme,Index,R) :-
	Eslesme = 0,
	icermePerm(MyList,Icerme,R).

/*
Bir sayiyi/sayilari iceren bir dizi ile olusturulabilecek tum olasi dizilerin bulunmasi
*/

icermePerm(MyList,I,R) :-
	dlist(InList),
	length(MyList,N),
    subset_perm(N,InList,R),
	icermeKontrol(MyList,I,R).
/*
Bir listede diger listede de bulunup bulunmadiginin kontrolu
*/
icermeKontrol(MyList,I,PermList) :-
	I > 0,
	subset(I,MyList,Subset),
	icermeSayisi(Subset,PermList,IcermeSayisi),
	IcermeSayisi = I,
	eslesmeSayisi(MyList,PermList,E),
	E = 0,!.

icermeKontrol(MyList,I,PermList) :-
	I = 0,
	icermeSayisi(MyList,PermList,IcermeSayisi),
	IcermeSayisi = 0,
	eslesmeSayisi(MyList,PermList,E),
	E = 0,!.
/*
Bir listede diger listede de bulunan kac sayinin oldugunun bulunmasi
*/
icermeSayisi([],_,0).

icermeSayisi([H|T],List2,R):-
        icermeSayisi(T,List2,R2),
        memberchk(H,List2),
        R is R2 + 1.

icermeSayisi([H|T],List2,R):-
        icermeSayisi(T,List2,R2),
        not(memberchk(H,List2)),
        R is R2.	
/*
Iki liste arasindaki tam eslesme sayisinin bulunmasi
*/
eslesmeSayisi([],[],0).

eslesmeSayisi([H|T],[B|S],R):-
        eslesmeSayisi(T,S,R2),
        esitMi(H,B),
        R is R2 + 1.

eslesmeSayisi([H|T],[B|S],R):-
        eslesmeSayisi(T,S,R2),
        not(esitMi(H,B)),
        R is R2.

esitMi(S1,S2):-
        S1 = S2.
	
