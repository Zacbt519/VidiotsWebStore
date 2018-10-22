CREATE PROCEDURE spGetFeaturedProducts
AS
BEGIN TRY
	SELECT ProductID, ProductName, BriefDescription, ImageURL, Price, AltText, Categories.Name  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID INNER JOIN Categories ON Product.CategoryID = Categories.CategoryID Where Featured = 1
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spGetAllCategories
AS
BEGIN TRY
	SELECT Name, Description, CategoryID FROM Categories
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

Alter PROCEDURE spGetProductsByCategory @CategoryID int, @ProdType int
AS
BEGIN TRY
	SELECT ProductID, ProductName, Price, ImageURL, BriefDescription, Name FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID Inner Join Categories on Categories.CategoryID = Product.CategoryID WHERE Product.CategoryID = @CategoryID and Type = @ProdType
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

ALTER PROCEDURE spGetProductsByType @TypeID int
AS
BEGIN TRY
	SELECT ProductID, ProductName, Price, ImageURL, BriefDescription, Name  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID INNER JOIN Categories ON Product.CategoryID = Categories.CategoryID WHERE Type = @TypeID
END TRY 
BEGIN CATCH
	THROW
END CATCH
GO;

ALTER PROCEDURE spGetSearchResults @Input varchar(50)
AS
BEGIN TRY
    IF EXISTS(SELECT * FROM Product WHERE ProductName LIKE '%' + @Input + '%' OR FullDescription LIKE '%' + @Input + '%' OR BriefDescription LIKE '%' + @Input + '%')
        SELECT ProductID, ProductName, Price, ImageURL, BriefDescription  FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID WHERE ProductName LIKE '%' + @Input + '%' OR FullDescription LIKE '%' + @Input + '%' OR BriefDescription LIKE '%' + @Input + '%'
    ELSE
        THROW 120000,'There are no products that meet the search term.',1
END TRY
BEGIN CATCH
    THROW
END CATCH
GO

CREATE PROCEDURE spInsertProduct @ProductName varchar(30), @BriefDescription varchar(200), @FullDescription varchar(max), @Price float, @ImageID int, @Featured bit, @ProductStatus char(1), @CategoryID int, @Type tinyint
AS
BEGIN TRY
	INSERT INTO Product (ProductName, BriefDescription, FullDescription, Price, ImageID, Featured, ProductStatus, CategoryID,Type) VALUES (@ProductName, @BriefDescription, @FullDescription, @Price, @ImageID, @Featured, @ProductStatus, @CategoryID, @Type)
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spUpdateProduct @ProductID smallint, @ProductName varchar(30), @BriefDescription varchar(200), @FullDescription varchar(max), @Price float, @ImageID int, @Featured bit, @ProductStatus char(1), @CategoryID int, @ProductType int
AS
BEGIN TRY
	UPDATE Product SET ProductName = @ProductName, BriefDescription = @BriefDescription, FullDescription = @FullDescription, Price = @Price, ImageID = @ImageID, Featured = @Featured, CategoryID = @CategoryID, Type = @ProductType WHERE ProductID = @ProductID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spDeleteProduct @ProductID smallint
AS
BEGIN TRY
	DELETE FROM Product WHERE ProductID = @ProductID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spInsertCategory @CategoryName varchar(15), @CategoryDescription varchar(200)
AS
BEGIN TRY
	INSERT INTO Categories (Name, Description) VALUES (@CategoryName, @CategoryDescription)
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spUpdateCategory @CategoryID int, @Name varchar(15), @Description varchar(200)
AS
BEGIN TRY
	Update Categories SET Name = @Name, Description = @Description WHERE CategoryID = @CategoryID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spDeleteCategory @CategoryID int
AS
BEGIN TRY
	DELETE FROM Categories WHERE CategoryID = @CategoryID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spGetAllProductInfoByID @ID smallint
AS
BEGIN TRY
	SELECT ProductName, BriefDescription, FullDescription, Price, Product.ImageID, ImageURL, AltText, Featured, ProductStatus, CategoryID, Type  FROM Product INNER JOIN Images on Images.ImageID = Product.ImageID WHERE ProductID = @ID
END TRY
BEGIN CATCH
	THROW
END CATCH
GO;

CREATE PROCEDURE spGetFullProductByID @ID smallint
AS
BEGIN TRY
    SELECT ProductName,FullDescription,Price,Product.ImageID,Featured,ProductStatus,CategoryID,Type,ImageURL,AltText FROM Product INNER JOIN Images ON Product.ImageID = Images.ImageID WHERE ProductID = @ID
END TRY
BEGIN CATCH
    THROW
END CATCH
GO

CREATE PROCEDURE spGetImageURL
AS
BEGIN TRY
	Select ImageURL, ImageID From Images
END TRY
BEGIN CATCH
	Throw;
END CATCH
GO;

CREATE PROCEDURE spGetProductType
AS
BEGIN TRY
	Select TypeID, Name From ProductType
END TRY
BEGIN CATCH
	Throw
END CATCH
GO;

Create proc spGetCategoryByTypeID @ID int
as
BEGIN TRY
	Select  Categories.Name, Categories.Description, Categories.CategoryID as 'CatID' From Categories Inner Join Product on Product.CategoryID = Categories.CategoryID Inner Join ProductType on ProductType.TypeID = Product.Type Where TypeID = @ID
END TRY
BEGIN CATCH
	THROW;
END CATCH
GO;

CREATE PROCEDURE spGetAllProductStatus
AS
BEGIN TRY
    SELECT StatusID,StatusDescription FROM ProductStatus
END TRY
BEGIN CATCH
    THROW
END CATCH
GO;

CREATE PROCEDURE [dbo].[spGetAllCategoryID]
AS
BEGIN TRY
    Select CategoryID,Name From Categories
END TRY
BEGIN CATCH
    Throw
END CATCH
GO

CREATE PROCEDURE spGetCategoryInfo @ID int
AS
BEGIN TRY
    IF EXISTS(SELECT * FROM Categories WHERE CategoryID = @ID)
        SELECT Name, Description FROM Categories WHERE CategoryID = @ID
    ELSE
        THROW 140000,'No Category exists with the given ID.',1
END TRY
BEGIN CATCH
    THROW
END CATCH
GO;

Alter PROC spCreateAccount @FirstName nvarchar(20), @MiddleInitial char(2) = null, @LastName nvarchar(30), @UserName nvarchar(20), @UserPassword nvarchar(20), @DateOfBirth date, @StreetAddress nvarchar(20), @City nvarchar(20),@PostalCode nvarchar(10), @Province char(2), @Country nvarchar(20), @PhoneNumber char(10), @EmailAddress nvarchar(30)
AS
BEGIN
    INSERT INTO
        Customer
    VALUES
        (@FirstName, @MiddleInitial, @LastName, @UserName, @UserPassword, @DateOfBirth, @StreetAddress, @City,@PostalCode, @Province, @Country, @PhoneNumber, @EmailAddress)
END
GO;

CREATE PROC spGetCustomerDetails @CustomerID smallint
AS
BEGIN
    SELECT DISTINCT
        FirstName, MiddleInitial, LastName, UserName, UserPassword, DateOfBirth, PhoneNumber, EmailAddress, Street, City, Country, Province, PostalCode 
    FROM 
        Customer INNER JOIN Address ON Customer.CustomerID = Address.CustomerID
    WHERE 
        Customer.CustomerID = @CustomerID AND AddressType = 'billing'
END
GO;

CREATE PROC spCreateAddress @Street nvarchar(50), @City nvarchar(50), @Province char(2), @Country nvarchar(50), @PostalCode char(6), @CustomerID smallint, @AddressType nvarchar(10)
AS
BEGIN
    INSERT INTO    
        Address
    VALUES
        (@Street, @City, @Province, @Country, @PostalCode, @CustomerID, @AddressType)
END
GO


ALTER PROC spCreateAccount @FirstName nvarchar(20), @MiddleInitial char(2) = null, @LastName nvarchar(30), @UserName nvarchar(20), @UserPassword nvarchar(20), @DateOfBirth date, @Street nvarchar(20), @City nvarchar(20),@PostalCode nvarchar(10), @Province char(2), @Country nvarchar(20), @PhoneNumber char(10), @EmailAddress nvarchar(30), @CustomerID int OUTPUT
AS
BEGIN
    INSERT INTO
        Customer
    VALUES
        (@FirstName, @MiddleInitial, @LastName, @UserName, @UserPassword, @DateOfBirth,  @PhoneNumber, @EmailAddress)

    SET @CustomerID = (SELECT CustomerID FROM Customer WHERE FirstName = @FirstName)
    EXEC spCreateAddress @Street, @City, @Province, @Country, @PostalCode, @CustomerID, 'billing'
END
GO;

CREATE PROC spCreateAddress @Street nvarchar(50), @City nvarchar(50), @Province char(2), @Country nvarchar(50), @PostalCode char(6), @CustomerID smallint, @AddressType nvarchar(10)
AS
BEGIN
    INSERT INTO    
        Address
    VALUES
        (@Street, @City, @Province, @Country, @PostalCode, @CustomerID, @AddressType)
END
GO

CREATE PROCEDURE spConfirmAccount @CustomerID smallint
AS 
Update Customer
Set isVerified = 1
Where CustomerID = @CustomerID
GO

ALTER PROC spGetAllCustomers
AS
BEGIN
    SELECT
        (LastName + ', ' + FirstName) AS CustomerName, IsArchived 
    FROM 
        Customer 
    WHERE
        IsArchived = 0
    ORDER BY 
        LastName

END

Create Procedure spCustomerSearch @Term varchar(20)
AS
	Declare @TempTerm varchar(25)
	Set @TempTerm = '"*' + @Term + '*"'
    Select 
        (LastName + ', ' + FirstName) AS CustomerName, IsArchived  
    From 
        Customer 
    Where 
        CustomerID LIKE @Term OR Contains(*, @TempTerm)
GO

Create proc spArchiveCustomer @CustomerID smallint
AS
BEGIN
    UPDATE
        Customer
    SET
        IsArchived = 1
    WHERE
        CustomerID = @CustomerID
END
GO

Alter Procedure spCreateCart
@CustomerID smallint null = null,
@CartID smallint Output
as
Begin
Insert into Cart Values( @CustomerID, GETDATE())
SET @CartID = @@IDENTITY
END 
GO;

alter Procedure spAddItemToCart @CartID smallint, @ProductID smallint, @Quantity int
AS
Begin
IF exists(Select * From CartItems Where ProductID = @ProductID AND CartID = @CartID)
Begin
Update CartItems Set Quantity = Quantity + 1 Where ProductID = @ProductID AND CartID = @CartID;

END
ElSE
Insert Into CartItems(ProductID, CartID, Quantity) Values(@ProductID, @CartID, @Quantity)
END
go;

Alter Procedure spGetCartItems @CartID smallint
AS
BEGIN
Select ProductName, Price, Quantity, CartItems.ProductID, (Price * Quantity) as ItemSubtotal From CartItems INNER JOIN  Product on CartItems.ProductID = Product.ProductID WHERE CartID = @CartID
END
GO;

alter Procedure spRemoveFromCart @ProductID smallint, @CartID smallint
AS 
BEGIN
Delete From CartItems Where ProductID = @ProductID AND CartID = @CartID
END

Create Procedure spUpdateQuantity @CartID smallint, @ProductID smallint, @Quantity int
AS
BEGIN
Update CartItems
Set Quantity = @Quantity
Where CartID = @CartID AND ProductID = @ProductID
END
GO;
