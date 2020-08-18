CREATE DATABASE ToyzUnlimited
--
CREATE TABLE Toys
(
	ProductCode	VARCHAR(5) 
	CONSTRAINT PK_Toys_ProductCode PRIMARY KEY(ProductCode),
	Name	VARCHAR(30),
	Category	VARCHAR(30),
	Manufacturer	VARCHAR(40),
	AgeRange	VARCHAR(15),
	UnitPrice	MONEY,
	Netweight	INT,
	QtyOnHand	INT
)
--Tao Bang
INSERT INTO Toys VALUES('SP01','Xep Hinh Pokemon','Lap Ghep','Rang Dong','3-5','45000',500,2000)
INSERT INTO Toys VALUES('SP02','Xep Hinh Doremon','Lap Ghep','Fisher Price','3-5','55000',400,200)
INSERT INTO Toys VALUES('SP03','Bup Be Babies','Cong Chua','Little Tikes','3-9','15000',200,100)
INSERT INTO Toys VALUES('SP04','Xep Hinh','Lego','Mattel','6-10','12000',900,3000)
INSERT INTO Toys VALUES('SP05','Xe Tang','Chien Thuat','Summer Infant','3-5','25000',500,2000)
INSERT INTO Toys VALUES('SP06','Ban May Bay','Chien Thuat','Do Choi Lego','3-7','5000',500,2000)
INSERT INTO Toys VALUES('SP07','Tau Lua','Chien Thuat','Rang Dong','3-7','42000',900,1000)
INSERT INTO Toys VALUES('SP08','Du Quay','Hanh Dong','Windy','6-9','35000',700,1000)
INSERT INTO Toys VALUES('SP09','Duoi Hinh','Chien Thuat','Rang Dong','4-6','45000',500,2000)
INSERT INTO Toys VALUES('SP010','Tu Lokho','Tri Tue','Joker Team','3-5','25000',500,4000)
INSERT INTO Toys VALUES('SP011','Game sd','Chien Thuat','Rang Dong','4-6','25000',400,1300)
INSERT INTO Toys VALUES('SP012','Ran san moi','Giai tri','Microsoft','3-5','42000',500,1234)
INSERT INTO Toys VALUES('SP013','Xep Hinh Pikachu','Lap Ghep','Rang Dong','3-5','45000',500,2000)
INSERT INTO Toys VALUES('SP014','Ban Ca An Xu','Tri Tue','Summer Infant','3-5','45000',500,200)
INSERT INTO Toys VALUES('SP015','Dua Xe','Hanh Dong','Rang Dong','3-12','25000',100,2000)
INSERT INTO Toys VALUES('SP016','Co Tuong','Tri Tue','Rang Dong','4-7','25000',500,2000)
--
SELECT * FROM Toys
--2
	CREATE PROCEDURE HeavyToys AS
	SELECT ProductCode,Category FROM Toys
	WHERE Netweight > 500
	--3
	CREATE PROCEDURE PriceIncreasecho AS
	SELECT ProductCode,Name,UnitPrice+10 AS SauKhiTangGia FROM Toys
	--4
	CREATE PROCEDURE QtyOnHand AS
	SELECT ProductCode,Name,QtyOnHand-5 AS SauKhiGiamSoLuong FROM Toys
	--5. 
	EXECUTE HeavyToys
	EXECUTE PriceIncreasecho
	EXECUTE QtyOnHand
	----------------------------------------
	--1
	sp_helptext HeavyToys
	sp_helptext PriceIncreasecho
	sp_helptext QtyOnHand

	SELECT OBJECT_DEFINITION (OBJECT_ID(N'HeavyToys')) AS ThucHienLenh; 
	SELECT OBJECT_DEFINITION (OBJECT_ID(N'PriceIncreasecho')) AS ThucHienLenh; 
	SELECT OBJECT_DEFINITION (OBJECT_ID(N'QtyOnHand')) AS ThucHienLenh; 
	--2.
	EXECUTE sp_depends HeavyToys
	EXECUTE sp_depends PriceIncreasecho
	EXECUTE sp_depends QtyOnHand
	GO
	--3
	ALTER PROCEDURE PriceIncreasecho AS
	UPDATE Toys SET UnitPrice=UnitPrice+5000
	GO
	SELECT *FROM Toys
	GO
	ALTER PROCEDURE QtyOnHand AS
	UPDATE Toys SET QtyOnHand=QtyOnHand-5
	GO
	SELECT *FROM Toys
	GO
	--4
	CREATE PROCEDURE SpecificPriceIncrease AS
	UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
	GO
	SELECT *FROM Toys
	GO
	--5
	ALTER PROCEDURE SpecificPriceIncrease @number int OUTPUT AS
	UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
	SELECT ProductCode,Name,UnitPrice as Price,QtyOnHand FROM Toys
	WHERE QtyOnHand>0
	SELECT @number = @@Rowcount
	GO
	DECLARE @num int
	EXECUTE SpecificPriceIncrease @num OUTPUT
	PRINT @num
	--6.
	ALTER PROCEDURE SpecificPriceIncrease @number int OUTPUT AS
	UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
	SELECT ProductCode,Name,UnitPrice as Price,QtyOnHand FROM Toys
	WHERE QtyOnHand>0
	SELECT @number = @@Rowcount
	execute HeavyToys
	--7
	--

	CREATE PROCEDURE usp_GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
BEGIN TRY  
    
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
 --
    EXECUTE usp_GetErrorInfo;  
END CATCH;   
	--8. 
	DROP PROCEDURE HeavyToys
	DROP PROCEDURE PriceIncreasecho
	DROP PROCEDURE QtyOnHand
