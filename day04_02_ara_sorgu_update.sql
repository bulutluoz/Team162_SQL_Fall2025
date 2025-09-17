

/* 
====================================== UPDATE ========================================
Bir tablodaki mevcut verileri değiştirmek için kullanılır.

Güncelleme yapılırken mutlaka WHERE koşulu kullanılmalıdır, 
aksi halde tüm kayıtlar güncellenebilir. 

Güncelleme yapılırken güncellenecek sütunların veri türüne 
ve kurallara uygun değerler almasına dikkat edilmelidir.

Relational bir database'de update yaparken daha dikkatli olunmasi gerekir.
 
PRIMARY KEY sutununda olmayan hic bir datanin 
FOREIGN KEY sutununda kullanilamayacagi unutulmamalidir.



-----Syntax-----
UPDATE table_name
SET field1=''
WHERE condition;

NOT : UPDATE işlemlerinin yapılabilmesi için 
Ayarlar -> SQL Editor -> "Safe Updates" 
check box'indaki tik işareti kaldırılıp kaydedilmeli, 
sonrasında MySQL kapatılıp tekrar açılmalıdır.
========================================================================================
*/




 /*  
========================  ORNEK  ========================
 Kitaplar tablosundaki Araba Sevdası kitabinin yazar adını 
 Recaizade Mahmut Ekrem olarak güncelleyin.
=========================================================
 */

UPDATE kitaplar
SET yazar_adi = 'Recaizade Mahmut Ekrem'
WHERE kitap_adi = 'Araba Sevdasi';


SELECT *
FROM kitaplar;


 /*  
========================  ORNEK  ========================
 Kitaplar tablosundaki Araba Sevdası kitabinin yayın yılını 1896, 
 kategorisini roman olarak güncelleyin.
=========================================================
 */

UPDATE kitaplar
SET yayin_yili = 1896 , kategori = 'Roman'
WHERE kitap_adi = 'Araba Sevdasi';


 /*  
========================  ORNEK  ========================
 Manav tablosunda 101 numaralı müşteriye satılan portakalın 
 fiyatını 20 olarak güncelleyin.
=========================================================
 */

UPDATE manav
SET urun_kg_fiyati = 20 
WHERE id = 101 AND urun_ismi = 'Portakal';

SELECT *
FROM manav;



 /*  
========================  ORNEK  ========================
 Manav tablosunda tüm elma fiyatlarını 
 tablodaki en ucuz elma fiyatına getirecek şekilde güncelleyin.
=========================================================
 */

UPDATE manav
SET urun_kg_fiyati = (SELECT MIN(urun_kg_fiyati)
					  FROM manav
                      WHERE urun_ismi = 'Elma') 
WHERE urun_ismi = 'Elma';

-- Error Code: 1093. You can't specify target table 'manav' for update in FROM clause	


-- once istenen degeri bir variable'a atayalim 

SET @en_ucuz_elma = (
    SELECT MIN(urun_kg_fiyati)
    FROM manav
    WHERE urun_ismi = 'Elma'
);

-- 2. Değeri değişkenden alarak güncelle

UPDATE manav
SET urun_kg_fiyati = @en_ucuz_elma
WHERE urun_ismi = 'Elma';



-- Variable oluşturup deger atama işlemi sorgu içinde de yapilabilir.

SELECT MIN(urun_kg_fiyati) INTO @min_elma
FROM manav
WHERE urun_ismi = 'Elma';



 /*  
=========================  NOT  =========================
 MySQL'de değişkenler (variables), geçici veri saklamak için kullanılır. 
 Özellikle sorgular arasında değer taşımak 
 veya karmaşık işlemleri adım adım yapmak için oldukça faydalıdır.
=========================================================
 */



 /*  
========================  ORNEK  ========================
 Ogretmen_id'si 11 olan hocadan ders alan ve soyadı kaya olan öğrencinin 
 soyadını Aslan yapın.
=========================================================
 */

UPDATE ogrenci
SET soyisim = 'Aslan'
WHERE soyisim = 'kaya' AND ogrenci_no IN(	SELECT ogrenci_no
											FROM dersler
											WHERE ogretmen_id=11);

SELECT *
FROM ogrenci;



 /*  
========================  NOT  ========================
 Related Tablolarda Kayit Guncelleme yaparken
 dikkat edilecek ana kural:
    PRIMARY KEY sutununda olmayan HIC BIR DATA
    FOREIGN KEY sutununda kullanilamaz
=========================================================
 */
 

 /*  
========================  ORNEK  ========================
 Dersler tablosunda id’si 20 olan kaydın notunu 88 yapın.
=========================================================
 */

UPDATE dersler
SET ortalama_not = 88
WHERE id= 20;


 /*  
========================  ORNEK  ========================
 Dersler tablosunda id’si 20 olan kaydın ogrenci_no’sunu 222 yapın.
=========================================================
 */

UPDATE dersler
SET ogrenci_no = 222
WHERE id= 20;

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
-- (`sqlvideodersleri`.`dersler`, CONSTRAINT `dersler_ibfk_1` FOREIGN KEY (`ogrenci_no`) REFERENCES `ogrenci` (`ogrenci_no`))



 /*  
========================  ORNEK  ========================
 Burcu Kaya'nin tarih dersindeki ortalama notunu 80 olarak guncelleyin.
=========================================================
 */

UPDATE dersler
SET ortalama_not = 80
WHERE ders_adi='tarih' AND ogrenci_no = (SELECT ogrenci_no
										 FROM ogrenci
										 WHERE isim='Burcu' AND soyisim = 'Kaya');


SELECT *
FROM dersler;



 /*  
========================  ORNEK  ========================
 Okul veri tabaninda 
 101 numaralı öğrencinin Matematik dersindeki hocasını Zeynep Demir yapın.
=========================================================
 */

UPDATE dersler
SET ogretmen_id = ( SELECT ogretmen_id
					FROM ogretmenler
                    WHERE isim = 'Zeynep' AND soyisim = 'Demir'
					)
WHERE ogrenci_no = 101 AND ders_adi = 'Matematik' ;



 /*  
========================  ORNEK  ========================
103 numaralı öğrencinin Tarih dersindeki ogretmen_id'sini 21 yapin
=========================================================
 */

UPDATE dersler
SET ogretmen_id = 21
WHERE ogrenci_no = 103 AND ders_adi = 'Tarih';

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`sqlvideodersleri`.`dersler`, CONSTRAINT `dersler_ibfk_2` FOREIGN KEY (`ogretmen_id`) REFERENCES `ogretmenler` (`ogretmen_id`))	0.0027 sec



 /*  
========================  ORNEK  ========================
 Zeynep Demir hocadan ders alan tüm öğrencilerin genel ortalama notunu hesaplayıp,
 Zeynep Demir hocadan ders alan tüm öğrencilerin notunu, 
 bu ortalama not olacak şekilde güncelleyin.
=========================================================
 */

-- asama asama gidelim

-- 1. Zeynep Demir hocanin ogretmen_id'sini bulup kaydedelim

SELECT ogretmen_id INTO @zeynepHocaId
FROM ogretmenler
WHERE isim = 'Zeynep' AND soyisim = 'Demir';

-- zeynep hocanin id'sini kullanarak dersler tablosunda
-- zeynep hocadan ders alanlarin genel ortalamasini bulup kaydedelim

SELECT AVG(ortalama_not) INTO @zeynepHocaOgrencileriGenelOrtalamaNot
FROM dersler
WHERE ogretmen_id = @zeynepHocaId;

-- zeynep hocadan ders alan tum ogrencilerin notunu
-- @zeynepHocaOgrencileriGenelOrtalamaNot olacak sekilde guncelleyelim

UPDATE dersler
SET ortalama_not = @zeynepHocaOgrencileriGenelOrtalamaNot
WHERE ogretmen_id = @zeynepHocaId;
