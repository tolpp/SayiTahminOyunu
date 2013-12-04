#SayiTahminOyunu 

Sayı dizisi tahmini oyunu, bir oyun yöneticisi ve bir adet de oyuncudan oluşan, yöneticinin belirlediği sayı dizisine oyuncunun ulaşmaya çalıştığı basit bir düşünme oyundur.

##Oyunun Oynanışı

Yönetici dört sayıdan oluşan [X,Y,Z,T] şeklinde bir dizi belirler. Bu diziyi bilmeyen oyuncu tahminlerle bu sayı dizisine ulaşmaya çalışır.
Her tahminden sonra yönetici oyuncuya tahminiyle ilgili bilgi vermelidir. Bu bilgi, oyuncunun tahminindeki kaç sayının belirlenen dizide bulunduğunu ve kaç sayının tam olarak belirlenen dizideki konumunda olduğunu içerir.

Bir örnekle;

Yöneticinin oyun başında belirlediği dizi [3,5,9,1] olsun. Buna göre aşağıdaki oyuncu tahminlerine göre yönetici şu bilgileri vermelidir :
* Tahmin : [1,2,3,4] --> Hedef dizideki 2 sayıyı içeriyor, 0 tanesi tam olarak eşleşmiş.
* Tahmin : [3,4,5,6] --> Hedef dizideki 2 sayıyı içeriyor, 1 tanesi tam olarak eşleşmiş
* Tahmin : [4,6,7,8] --> Hedef dizideki 0 sayıyı içeriyor, 0 tanesi tam olarak eşleşmiş.
* Tahmin : [3,1,5,9] --> Hedef dizideki 4 sayıyı içeriyor, 1 tanesi tam olarak eşleşmiş.
* Tahmin : [3,5,9,1] --> Hedef dizideki 4 sayıyı içeriyor, 4 tanesi tam olarak eşleşmiş. Tahmin doğru.

Oyundaki amaç mümkün olan en az adımda yöneticinin belirlediği sayıya ulaşmaktır. Karşılıklı olarak ancak iki oyun şeklinde oynanabilir. Eş zamanlı oynanmak istendiğinde bir oyuncu karşısındaki oyunun yöneticisi, diğer oyuncu da diğer oyunun yöneticisi konumuna geçer.

##Oyunun Kuralları

* Belirlenen ve tahmin edilecek sayı dizisi 4 sayıdan oluşmalıdır.
* Bir dizi içerisinde aynı sayı tekrar edemez.
* Dizi için seçilecek sayılar 1-9 kapalı aralığından seçilmelidir.
* Yönetici tahmin edilen sayı dizisi için doğru bilgi vermekle yükümlüdür.

##Oyunun Temeli

Oyunun gerçek ismi Mastermind. Oyun, lisede arkadaşlar arasında oynadığımız bir oyundu.
Sayılar yerine renkler kullanılarak oynanan çok benzer bir oyuna şuradan ulaşılabilir : http://www.gamesforthebrain.com/game/guesscolors/ . Renk tahmini oyununun bu oyundan farkı, 9 adet sayı yerine 6 renk kullanılıyor olması ve renklerin tekrar edebiliyor olmasıdır.

##Geliştirilen Programlar Hakkında

Programlar Prolog programlama dili kullanılarak SWI-Prolog altında geliştirilmiştir. SWI-Prolog üzerinde test edilmiş programlar SWI’ın kütüphanelerinden bol miktarda yararlanmıştır. 

Proje iki ayrı program olarak geliştirilmiştir :

1. Bilgisayarın yönetici olduğu kısım
2. Bilgisayarın oyuncu olduğu kısım

### 1 - Oyun Yöneticisi Olarak Bilgisayar ve Programın Gerçekleştirimi

Bu kısımda bilgisayar program vasıtasıyla yönetici pozisyonuna geçer. Kurallar dahilinde üretilen rastgele sayı dizisine insan olan oyuncunun ulaşması beklenir. Her adımda program kullanıcıdan yeni tahmin alır ve bu tahminler kullanıcı rastgele belirlenen sayı dizisine ulaşana kadar devam eder.

run. komutuyla program başlatılır. Ardından her adımda kullanıcıdan [X,Y,Z,T]. şeklinde 4 farklı sayıdan oluşan sayı dizisi girilmesi beklenir. Sayı dizisi köşeli parantez içerisinde, sayılar arasında virgüllerle ayrılmış şekilde girilmelidir. Parantezin dışına nokta (‘.’) koyulmalıdır. İşlemin başlaması içinse verilen sayı dizisi Enter (return) tuşuyla programa verilmelidir.

Gönderilen sayı tahmini dizisinin ardından belirlenen dizide kaç içerme, kaç eşleşme olduğu bilgisayar tarafından kullanıcıya döndürülür.

### 2 - Oyuncu Olarak Bilgisayar ve Programın Gerçekleştirimi

Bu kısımda bilgisayar oyuncudur. Yönetici konumundaki insan oyun kurallarına uygun bir şekilde sayı dizisi belirler. Her adımda program bir sayı tahmininde bulunur ve program kullanıcısı bilgisayara belirlediği sayı dizisiyle bilgisayarın tahmin ettiği sayı dizisi arasındaki içerme ve eşlenme bilgisini verir.

run. komutuyla program başlatılır. Bilgisayar bir tahminde bulunur ve kullanıcıdan [I,E]. şeklinde iki sayı dizisi arasındaki içerme ve eşlenme verisini bekler.

Eşlenme sayısı dizi sayısına eşit olana kadar her adımda bilgisayar yeni bir tahminde bulunur ve bu her adımda kullanıcının bilgi girmesini bekler.

