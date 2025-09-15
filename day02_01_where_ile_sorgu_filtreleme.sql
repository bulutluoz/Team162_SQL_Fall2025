
/*
===============================================
          Karsilastirma Operatorleri
===============================================
 WHERE ile filtreleme yaparken = isareti disinda 
	büyüktür >
	büyük eşittir >=
	küçüktür <
	küçük eşittir <= 
 gibi karşılaştırma operatorleri de kullanilabilir.


 <> veya !=  İsaretleri iki değerin birbirine eşit olmadığını kontrol eder.

*/

SELECT *
FROM ogrenciler;

-- tedarikciler tablosundaki isimleri yazdirin

SELECT tedarikci_ismi
FROM tedarikciler;

-- people tablosundaki isim ve soyisimleri listeleyin

SELECT isim,soyisim
FROM people;

 /*  
========================  ORNEK  ========================
 People tablosunda yasi 30’dan buyuk olan kişilerin bilgilerini listeleyin.
=========================================================
 */
 
 
SELECT *
FROM people
WHERE yas > 30;





/*
===============================================
					NOT
===============================================
 CHAR veya VARCHAR türündeki ifadeler için de büyüktür (>) ve küçüktür (<) operatörleri kullanılabilir. 

 Bu operatörler, karakter dizileri (metinler) arasında 
 alfabetik veya leksikografi kurallarına göre karşılaştırma yapar. 
 
 Bu tür karşılaştırmalar, karakter dizilerinin alfabetik sırasına göre 
 büyük veya küçük olup olmadıklarını belirlemek için kullanılır. 
 (ASCII tablosundaki yerlerine göre karakterleri sıralar)
 
 MySql case sensitive degildir
 case sensitive olmasi ozellikle istenmedikce
 kucuk buyuk harf ayirimi yapmaz
*/
 
 /*  
========================  ORNEK  ========================
 People tablosunda ismi 'emre’ isminden sonra gelen kişilerin 
 isimlerini listeleyin.
=========================================================
 */
 
SELECT isim
FROM people
WHERE isim > 'emre';


SELECT isim
FROM people
WHERE isim > 'EMRE';

SELECT isim
FROM people
WHERE isim > 'Emre';


 
 
 /*  
========================  ORNEK  ========================
 People tablosunda sehir ismi 'D' den sonra olan sehirlerde 
 yasayan kisilerin 
 isim ve soyisim  bilgilerini listeleyin.
=========================================================
 */
 
SELECT isim,soyisim
FROM people
WHERE sehir > 'D';

-- D  <  Diyarbakir
-- illa da cozelim, D ile baslayan sehirler olmasin denirse

SELECT isim,soyisim
FROM people
WHERE sehir >= 'E';

 
 
 /*  
========================  ORNEK  ========================
 People tablosunda yasi 35 den kucuk veya 35'e esit olan kişilerin 
 bilgilerini listeleyin.
=========================================================
 */
 
SELECT *
FROM people
WHERE yas<= 35;



 
 
 /*  
========================  ORNEK  ========================
 People tablosunda sehri Trabzon olmayan kişilerin bilgilerini listeleyin.
=========================================================
 */
 
 SELECT *
 FROM people
 WHERE sehir != 'Trabzon';
 
 
 SELECT *
 FROM people
 WHERE sehir <> 'Trabzon';



 
 /*  
========================  ORNEK  ========================
 People tablosunda soyismi Gunes olmayan kişilerin bilgilerini listeleyin
=========================================================
 */
 
SELECT *
FROM people
WHERE soyisim <> 'Gunes' ;





/*
===============================================
        Mantiksal Operatorler / AND
===============================================
Mantıksal operatörler, sorgularda belirli koşulların nasıl birleştirileceğini 
ve birlikte değerlendirilebileceğini kontrol eder. 

Bu operatörlerin kullanımı, veritabanı sorgularının esnekliğini ve gücünü artırır.

AND (Ve): Birden fazla koşulun aynı anda karşılanması gerektiğinde kullanılır.

OR (Veya): Birden fazla koşuldan en az birinin sağlanması gereken durumlarda kullanılır.

WHERE NOT: Belirli bir koşulun tersini almak için kullanılır.

*/
 
 /*  
========================  ORNEK  ========================
 People tablosunda 29 yaşından büyük olan ve Ankara'da yaşayan 
 kişileri listeleyin.
=========================================================
 */
 
SELECT *
FROM people
WHERE yas > 29 AND sehir = 'Ankara';



 
 
 /*  
========================  ORNEK  ========================
People tablosunda Adı 'Fatma' olan ve Bursa'da yaşayan kişilerin 
yasini listeleyin
=========================================================
 */
 

SELECT yas
FROM people
WHERE isim = 'Fatma' AND sehir = 'Bursa' ;



 
 /*  
========================  ORNEK  ========================
 People tablosunda ismi 'Ayse’ veya soyismi 'Kaya' olan kişileri listeleyin
=========================================================
 */
 
SELECT *
FROM people
WHERE isim ='Ayse' OR soyisim = 'kaya' ;



SELECT *
FROM people
WHERE isim ='Ayse' || soyisim = 'kaya' ;
 
 
 
 /*  
========================  ORNEK  ========================
 People tablosunda yaşı 22 veya 35 olan kişileri listeleyin
=========================================================
 */
 
SELECT *
FROM people
WHERE yas = 22 || yas = 35;

-- sartlari yazarken her bir degerin bir sutunla karsilastirilmasi beklenir
-- WHERE yas = 22 || 35;
-- WHERE yas = (22 || 35); kullanimlari istenen islemi yapmaz

 
 
 /*  
========================  ORNEK  ========================
 People tablosunda 29 yaşından büyük olan 
 veya Ankara'da yaşayan kişileri listeleyin
=========================================================
 */
 
SELECT *
FROM people
WHERE yas > 29 || sehir = 'Ankara' ;




 
 
 /*  
========================  ORNEK  ========================
 People tablosunda İstanbul, Ankara veya İzmir'de yaşayan kişileri listeleyin
=========================================================
 */

SELECT *
FROM people
WHERE sehir = 'İstanbul' || sehir = 'Ankara' || sehir = 'Izmir';




 
  /* 
===============================================
                   BETWEEN
===============================================
 BETWEEN (Arasında): Bir aralıktaki değerleri seçmek için kullanılır

 Bu anahtar kelime genellikle sayısal değerler, tarihler ve metinlerle kullanılır
 ve belirtilen iki değer arasındaki tüm değerleri kapsar. 

 BETWEEN ile belirlenen aralık her iki uç değeri de içerir, yani "başlangıç" ve "bitiş"
 değerleri sorgu sonuçlarına dahildir.
 
 *************** SYNTAX ***************
 SELECT sütun_adı
 FROM tablo_adı
 WHERE sütun_adı BETWEEN değer1 AND değer2;


 NOT BETWEEN : Bir aralık dışındaki değerleri seçmek için kullanılır

 Iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme imkani verir. 
 Yazdigimiz 2 sinir da araliga dahil degildir (EXCLUSIVE) 
 
 *************** SYNTAX ***************
 SELECT sutun_adi 
 FROM tablo_adı 
 WHERE sütun_adı NOT BETWEEN deger1 AND deger2;
 
 
*/
 
 /*  
========================  ORNEK  ========================
 People tablosunda yaşı 25 ile 35 arasında olan kişileri listeleyin.
=========================================================
 */
 

SELECT *
FROM people
WHERE yas >= 25 AND yas <= 35 ;



SELECT *
FROM people
WHERE yas BETWEEN 25 AND 35;
 
 
 /*  
========================  ORNEK  ========================
 People tablosunda 
 yaşı 25 ile 35 arasında olan ve Ankara'da yaşayan kişileri listeleyin.
=========================================================
 */


SELECT *
FROM people
WHERE yas BETWEEN 25 AND 35 AND sehir = 'Ankara' ;



 
 
 /*  
========================  ORNEK  ========================
 People tablosunda ismi Adem ile Aylin arasında olan 
 ve Ankara'da yaşayan kişileri listeleyin.
=========================================================
 */
 
SELECT *
FROM people
WHERE isim BETWEEN 'Adem' AND 'Aylin' AND sehir = 'Ankara';








 
  /*  
========================  ORNEK  ========================
 People tablosunda ismi K ile T arasında olmayan kişileri listeleyin.
=========================================================
 */
 
SELECT *
FROM people
WHERE isim NOT BETWEEN 'K' AND 'T';






 /*
===============================================
                  IN OPERATORU
===============================================

 Belirli bir sütunun değerlerini, verilen bir listedeki değerler ile karşılaştırmak için kullanılır
 
 Bu operatör, sorgulanacak değerlerin bir listesini parantez içinde alır 
 ve belirtilen sütunun değeri bu listedeki herhangi bir değerle eşleşirse, 
 o satırı sonuç kümesine dahil eder. 
 
 IN operatörü, birden çok OR koşulunu daha okunaklı ve kısa bir şekilde yazmanın bir yoludur.

*************** SYNTAX ***************
SELECT sütun_adları
FROM tablo_adi
WHERE sütun_adi IN (değer1, değer2, ..., değerN);
*/ 
 
  /*  
========================  ORNEK  ========================
 People tablosunda İstanbul, Ankara veya İzmir'de yaşayan kişileri listeleyin.
=========================================================
 */
 

SELECT *
FROM people
WHERE sehir = 'İstanbul' || sehir = 'Ankara' || sehir = 'Izmir';

SELECT *
FROM people
WHERE sehir IN ('İstanbul', 'Ankara', 'Izmir');

 
 
  /*  
========================  ORNEK  ========================
 People tablosunda adı 'Ahmet', 'Mehmet' veya 'Ayşe' olan kişileri listeleyin.
=========================================================
 */
 

SELECT *
FROM people
WHERE isim IN ( 'Ahmet', 'Mehmet', 'Ayşe');




 
 /*
===============================================
        Mantiksal Operatorler / NOT
===============================================
 
 Bir koşulun sonucunu tersine çevirmek için kullanılır. 
 
 Eğer islem sonucu TRUE ise, "NOT" operatörü sonucu FALSE yapar, sonuc FALSE ise TRUE yapar.

 Genellikle "NOT IN", "NOT EXISTS", "NOT LIKE" gibi ifadelerde kullanılır.


*************** SYNTAX ***************
SELECT * FROM tablo_adı 
WHERE NOT sütun_adı = 1;
*/ 
 
  /*  
========================  ORNEK  ========================
  People tablosundan  İstanbul'da yaşamayan kişileri listeleyiniz.

=========================================================
 */
 
 SELECT *
 FROM people
 WHERE sehir <> 'Istanbul' ;



 SELECT *
 FROM people
 WHERE sehir NOT IN ( 'Istanbul' ) ;

 
 
  /*  
========================  ORNEK  ========================
 people tablosundan 30 yaşından büyük olmayan kişileri listeleyiniz.
=========================================================
 */








 
  /*  
========================  ORNEK  ========================
 people tablosundan soyadı 'Yılmaz' veya 'Kara' olmayan kişileri listeleyiniz.
=========================================================
 */ 
 









 
 