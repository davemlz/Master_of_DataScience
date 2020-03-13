---------------------------------------------------------------------------------------------------------
-- Inserción de datos para consultas en SQLite
-- 
-- M�ster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Informaci�n 2018-2019
-- DIego Garc�a Saiz
-----------------------------------------------------------------------------------------------------------



INSERT INTO articulos (codigart , descrart,preunart , stockart,stockmin, fecbaja ) VALUES 
 ('0001','MESA OFICINA 90x1,80',225,100,1,null),
 ('0002','SILLA ERGONOMIC MOD. MX',120,25,1,null),
 ('0003','ARMARIO DIPLOMATIC',300,2,1,null),
 ('0004','ARCHIVADOR MOD. TR',180,3,1,null),
 ('0005','PANTALLA 19',110,2,1,'2018-02-06');
 
 INSERT INTO  proveedores  ( codigpro , cifpro , nombrpro , direcpro , cpostpro ,  localpro  , faxpro ,telefpro, emailpro , procepro ) VALUES 
 ('P001','A39184215','Bau Pi, Pablo','Alta 3, 2D','39390','Santander','(34) 942 223 344','(34) 942 223 345','mailto:baupi@eresmas.es','UE'),
 ('P002','A48162311','Zar Luna, Ana','Ercilla 22, 1A','48002','Bilbao','(34) 947 865 434','(34) 947 865 413','mailto:zarana@yahoo.es','UE'),
 ('P003','B28373212','Gras Leon, Luz','Pez 14, 5C dcha.','28119','Madrid','(34) 916 677 889','(34) 916 677 829',NULL,'UE'),
 ('P004','B85392314','Gil Laso, Luis','Uria 18, 2F','85223','Oviedo','(34) 952 345 678','(34) 952 345 6632',NULL,'UE');

 INSERT INTO  pedidos  ( numped , codigpro , fechaped , ivaped , fentrped ) VALUES 
 (1,'P001','2010-05-22',21,'2010-06-16'),
 (2,'P002','2010-06-10',18,'2010-08-15'),
 (3,'P003','2010-10-15',18,'2010-12-15'),
 (4,'P001','2010-08-13',18,'2010-09-10'),
 (5,'P004','2010-11-13',21,'2010-11-13');
 
 
 INSERT INTO  lineas  ( numped , numlin , codigart , unilin , preunlin , desculin ) VALUES 
 (1,1,'0001',1,220,0),
 (1,2,'0003',2,295,0),
 (2,1,'0002',3,120,2),
 (2,2,'0003',2,300,3),
 (2,3,'0002',5,120,0),
 (3,1,'0002',1,110,0),
 (4,1,'0002',4,120,0),
 (4,2,'0004',10,180,0);