/*
================================= SUBQUERY =================================
    Subquery (alt sorgu), bir sorgunun içinde yer alan 
    ve genellikle SELECT, FROM veya WHERE ifadelerinde kullanılan başka bir sorgudur. 
    
    Alt sorgu, dış sorguya veri sağlamak için çalışır. 
    Genellikle filtreleme, karşılaştırma veya hesaplama işlemleri için kullanılır.

    Örneğin, onceki derste olusturulan okul relational schema'sinda 
    matematik dersini alan öğrenci isimleri sorulsa

    Bir query ile dersler tablosunda matematik dersi alan öğrencilerin numaraları bulanabilir 
    ama öğrencilerin isimlerini bulmak için öğrenci numaraları ile öğrenci tablosunda alt sorgu yapılmalıdır.
============================================================================
*/





 /*  
========================  ORNEK  ========================
 Okul veri tabanında matematik dersi alan öğrenci isim ve soy isimlerini yazdırın.
=========================================================
 */
 
-- burada insan olarak dusunulse 
-- once dersler tablosundan matematik dersi alan ogrenci numaralari bulunur

SELECT DISTINCT ogrenci_no
FROM dersler
WHERE ders_adi = 'matematik';

-- 101,103,109,118,129,141,151


-- Sonra bu numaralara sahip ogrencilerin isim ve soyisimleri ogrenci tablosundan sorgulanir

SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (101,103,109,118,129,141,151);


-- Ama bu yol dinamik değildir yani tablo degisse calismaz, 
-- yeniden manuel kontrol edilip düzeltilmesi gerekir.

-- Kodlarin dinamik olmasi icin 
-- ogrencilerin numaralarini getiren ilk sorgu
-- ikinci sorgudaki IN parantezinin icine yazilabilir.


SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (	SELECT DISTINCT ogrenci_no
						FROM dersler
						WHERE ders_adi = 'matematik');


 /*  
========================  ORNEK  ========================
 Ornek :  okul veri tabaninda herhangi bir derste notu 85'den fazla olan ogrencilerin 
 isim ve soyisimlerini yazdirin.
 Bir ogrenci birden fazla dersten yuksek not almissa tekrar yazilmasin
=========================================================
 */
 
 -- once dersler tablosundan yüksek not alan ogrenci numaralari tekrarsiz olarak bulunur

SELECT DISTINCT ogrenci_no
FROM dersler
WHERE ortalama_not > 85;


-- Sonra bu numaralara sahip ogrencilerin isim ve soyisimleri ogrenci tablosundan sorgulanir

SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (101,103,112,123);



-- ogrencilerin numaralarini getiren ilk sorguyu
-- ikinci sorgudaki IN parantezinin icine yazilabilir.


SELECT isim, soyisim
FROM ogrenci
WHERE ogrenci_no IN (	SELECT DISTINCT ogrenci_no
						FROM dersler
						WHERE ortalama_not > 85);


 /*  
========================  ORNEK  ========================
 okul veri tabaninda matematik dersinden en yüksek not ortalamasina sahip ogrencinin 
 isim ve soyismini yazdirin.
=========================================================
 */
 
 -- once dersler tablosundan en yüksek matematik notuna sahip ogrencinin notunu bulalim

SELECT MAX(ortalama_not)
FROM dersler
WHERE ders_adi = 'Matematik';
-- 92



-- Sonra matematikten bu notu alan ogrencinin numarasi dersler tablosundan sorgulanir

SELECT ogrenci_no
FROM dersler
WHERE ders_adi = 'Matematik' AND ortalama_not = 92 ;

-- 129




-- Son olarak bu numaraya sahip ogrencinin isim ve soyisimi ogrenci tablosundan sorgulanir

SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no = 129;




-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.


SELECT isim,soyisim
FROM ogrenci
WHERE ogrenci_no = (SELECT ogrenci_no
					FROM dersler
					WHERE ders_adi = 'Matematik' AND ortalama_not = (	SELECT MAX(ortalama_not)
																		FROM dersler
																		WHERE ders_adi = 'Matematik'));

 /*  
========================  ORNEK  ========================
 okul veri tabaninda Zeynep Demir hocadan ders alan ogrencilerin sayisini yazdirin.
=========================================================
 */
 
-- once ogretmenler tablosundan Zeynep Demir hocanin ogretmen_id’sini bulalim

SELECT ogretmen_id
FROM ogretmenler
WHERE isim = 'zeynep' AND soyisim = 'demir' ;

-- 12


-- Sonra dersler tablosundan ogretmen_id’si 12 olan ogrenci sayisi sorgulanir

SELECT COUNT(ogretmen_id) AS 'hocanin ogrenci sayisi'
FROM dersler
WHERE ogretmen_id = 12;


-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.


SELECT COUNT(ogretmen_id) AS 'hocanin ogrenci sayisi'
FROM dersler
WHERE ogretmen_id = (	SELECT ogretmen_id
						FROM ogretmenler
						WHERE isim = 'zeynep' AND soyisim = 'demir' );





 /*  
========================  ORNEK  ========================
 okul veri tabaninda 129 numarali ogrencinin ingilizce hocasinin 
 ismini ve soyismini yazdirin.
=========================================================
 */
SELECT ogretmen_id
FROM dersler
WHERE ogrenci_no = 129 AND ders_adi = 'ingilizce' ;

SELECT isim,soyisim
FROM ogretmenler
WHERE ogretmen_id = 17;


-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.

SELECT isim,soyisim
FROM ogretmenler
WHERE ogretmen_id = (	SELECT ogretmen_id
						FROM dersler
						WHERE ogrenci_no = 129 AND ders_adi = 'ingilizce' );




 
 
 /*  
========================  ORNEK  ========================
 okul veri tabaninda bir dersten bir ogrencinin aldigi en yuksek notu bulun
bu notu veren hocanin ismini ve soyismini yazdirin.
=========================================================
 */
 
-- once dersler tablosundan bir dersten bir ogrencinin aldigi en yüksek ortalama bulunur







-- Sonra dersler tablosundan bu ortalama notu veren hocanin ogretmen_id’si sorgulanir








-- Son olarak ogretmenler tablosundan ogretmen_id’si 14 olan ogretmenin isim ve soyismi sorgulanir
-- ayni notu veren birden fazla hoca olabilecegi icin IN kullanilabilir







-- Kodlarin dinamik olmasi icin son sorgudan başlayarak sorgular İc ice yazilabilir.







 

/* 
======================== SELECT ile SUBQUERY ===========================

SELECT ile SUBQUERY kullanimi :
  
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
  
 * Yazdığımız QUERY'lerde SELECT satırında field isimleri kullanıyoruz. 
   Eğer SELECT satırında bir SUBQUERY yazılırsa, sonuç olarak tek bir kayıt değil bir field döndürür.

 * SELECT satirinda SUBQUERY yazacaksak SUM, COUNT, MIN, MAX ve AVG gibi 
  fonksiyonlar kullanilir. Bu fonksiyonlara AGGREGATE FUNCTION denir.
  
 => Interview Question : Subquery'i Select satirinda kullanirsaniz ne ile 
kullanmaniz gerekir?

=========================================================================\
*/ 
 
-- zeynep demir'den ders alan ogrencilerin genel not ortalamasini bulun

-- once zeynep demir'in ogretmen nosunu bulalim
SELECT ogretmen_id
FROM ogretmenler
WHERE isim = 'zeynep' AND soyisim = 'demir' ;

-- 12

-- sonra ogretmen_id'si 12 olan ogrenci notlarinin genel ortalamasini aggregate fonksiyon ile bulalim
SELECT AVG(ortalama_not)
FROM dersler
WHERE ogretmen_id = 12;


SELECT AVG(ortalama_not)
FROM dersler
WHERE ogretmen_id = (	SELECT ogretmen_id
						FROM ogretmenler
						WHERE isim = 'zeynep' AND soyisim = 'demir');

 

 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan ogrencilerin notlarinin ortalamasini listeleyen bir QUERY yazin.
=========================================================
 */
 
 
 SELECT isim,soyisim,ders_adi, (SELECT AVG(ortalama_not)
								FROM dersler
								WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id)
 FROM ogretmenler ;
 
 
 
/*
Verilen görev incelendiğinde, ismini, soyismini, branş bilgilerinin ogretmenler tablosundan bulunabileceği görülecektir.
Not ortalamasi ise dersler tablosundaki kayitlardan Aggregate fonksiyonu kullanılarak elde edilebilir.
Iki tablo arasinda baglanti ogretmen_id ile kurulabilir.


SELECT isim,soyisim,ders_adi, (buraya ortlama notu hesaplayan bir sorgu gelmeli)
FROM ogretmenler;

ornegin sadece ogretmen_id 11 olan ogretmenin 
ogrencilerinin genel not ortalamasini goruntulemek icin
asagidaki query yazilabilirdi

SELECT AVG(ortalama_not)  
FROM dersler 
WHERE ogretmen_id = 11) AS '11 nolu ogretmenin ogrencilerinin genel not ortalamasi'

*/



 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan ogrenciler icinde en yuksek ortalama notu 
 listeleyen bir QUERY yazin.
=========================================================
 */
 
SELECT isim, soyisim, ders_adi, (	SELECT MAX(ortalama_not)
									FROM dersler
									WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id)
FROM ogretmenler ;



-- 11 numarali hocadan ders alanlar icinde en yuksek puanli ogrencinin notunu bulalim
SELECT MAX(ortalama_not)
FROM dersler
WHERE ogretmen_id = 12;


 /*  
========================  ORNEK  ========================
 Her bir ogretmenin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
SELECT  isim, soyisim,ders_adi, (	SELECT COUNT(ortalama_not)
									FROM dersler
									WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) 
                                    AS 'hocadan ders alan ogrenci sayisi'
FROM ogretmenler;



-- 11 numarali hocadan ders alan ogrencilerin sayisini bulalim
SELECT COUNT(ortalama_not)
FROM dersler
WHERE ogretmen_id = 11;

 

 /*  
========================  ORNEK  ========================
 Matematik anlatan ogretmenlerin, ismini, soyismini, bransini 
 ve dersini alan kac ogrenci oldugunu listeleyen bir QUERY yazin.
=========================================================
 */
 
 SELECT  isim, soyisim,ders_adi, (	SELECT COUNT(ortalama_not)
									FROM dersler
									WHERE ogretmenler.ogretmen_id = dersler.ogretmen_id) 
                                    AS 'hocadan ders alan ogrenci sayisi'
FROM ogretmenler
WHERE ders_adi = 'Matematik';






 /*  
========================  ORNEK  ========================
 Her bir ogrencinin ismini, soyismini ve kac ders aldigini yazdirin.
=========================================================
 */
 
 SELECT isim, soyisim,(	SELECT COUNT(ders_adi)
						FROM dersler
						WHERE ogrenci.Ogrenci_no = dersler.ogrenci_no)
 FROM ogrenci;


-- 101 numarali ogrencinin kac ders aldigini yazdirin

SELECT COUNT(ders_adi)
FROM dersler
WHERE Ogrenci_no = 101;




 /*  
========================  ORNEK  ========================
 Soyadi Kaya olan ogrencilerin ismini, soyismini 
 ve aldigi tum derslerin genel not ortalamasini yazdirin.
=========================================================
 */
 
 SELECT isim, soyisim , (	SELECT AVG(ortalama_not)
							FROM dersler
							WHERE ogrenci.ogrenci_no = dersler.ogrenci_no)
 FROM ogrenci
 WHERE soyisim = 'kaya';
 


-- 101 numarali ogrencinin genel not ortalamasini yazdirin

SELECT AVG(ortalama_not)
FROM dersler
WHERE ogrenci_no = 101;


 
 /*  
========================  ORNEK  ========================
 mi c ile l arasinda olan ogrencilerin
ismini, soyismini ve aldigi dersler icinde en yuksek ortalamaya sahip olan dersin notunu yazdirin.
=========================================================
 */
 
 




 

/* 
======================== EXISTS CONDITION ===========================
EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanimina
benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen 
degerlerin icerisinde bir degerin olmasi veya olmamasi durumunda islem 
yapilmasini saglar.
======================================================================
*/
 
 
 
 



 /*  
========================  ORNEK  ========================
 Nisan_satislar ve mayis satislar iki tablo oluşturup null olmayan kayitlar ekleyin.
=========================================================
 */
 
 CREATE TABLE mayis_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (20, 'John', 'Toyota');
INSERT INTO mayis_satislar VALUES (30, 'Amy', 'Ford');
INSERT INTO mayis_satislar VALUES (20, 'Mark', 'Toyota');
INSERT INTO mayis_satislar VALUES (10, 'Adem', 'Honda');
INSERT INTO mayis_satislar VALUES (40, 'John', 'Hyundai');
INSERT INTO mayis_satislar VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');

SELECT * 
FROM mayis_satislar;


SELECT * 
FROM nisan_satislar;










 /*  
========================  ORNEK  ========================
 Her iki ayda da ayni id ile satilan urunlerin 
 urun_id'lerini ve urunleri mayis ayinda alanlarin isimlerini 
 getiren bir query yaziniz.
=========================================================
 */
 
 SELECT urun_id, musteri_isim
 FROM mayis_satislar
 WHERE urun_id IN (	SELECT urun_id
					FROM nisan_satislar
					WHERE mayis_satislar.urun_id = nisan_satislar.urun_id );

-- yukardaki sorgu tam olarak istenen bilgiyi veriyor
-- ancak 10 ve 20 degerlerini biz gozlem ile bulup yazdik
-- bu da dinamik olmaz
-- dinamik olmasi icin bize her iki ayda var olan urun_id'lerini getirecek bir sorgu lazim



 /*  
========================  ORNEK  ========================
 mayis ayinda olup, nisan ayinda olmayan id'leri 
 ve mayis ayinda o urunu alan müşteri isimlerini görüntüleyin.
=========================================================
 */
 

 SELECT urun_id, musteri_isim
 FROM mayis_satislar
 WHERE urun_id NOT IN (	SELECT urun_id
						FROM nisan_satislar
						WHERE mayis_satislar.urun_id = nisan_satislar.urun_id ); 
 
 
 
 
 
 
 