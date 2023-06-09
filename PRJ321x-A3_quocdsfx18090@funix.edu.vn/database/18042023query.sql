/*USE [ShoppingDB]
GO
/****** Object:  StoredProcedure [dbo].[createBill]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc  [dbo].[createBill]
@user_mail nvarchar(100), @id_product INT , @amount INT, @discount varchar(8)
as
begin
	declare @count int = 0, @id_order int;
	Select @count = COUNT(*) from Orders where DAY(order_date) = DAY(GETDATE()) and MONTH(order_date) = MONTH(GETDATE()) and YEAR(order_date) = YEAR(GETDATE()) and user_mail = @user_mail and order_status = 0;
	if (@count = 0)
		begin
			Insert into Orders (user_mail, order_status, order_date, order_discount_code, order_address) 
			values (@user_mail, 0 , GETDATE(), @discount, (Select user_address from Account where user_mail = @user_mail));	
		end
	set @id_order = (Select order_id from Orders where user_mail = @user_mail and  DAY(order_date) = DAY(GETDATE()) and MONTH(order_date) = MONTH(GETDATE()) and YEAR(order_date) = YEAR(GETDATE())and order_status = 0);
	set @count = 0;
	select @count = COUNT(*) from Orders_detail where product_id = @id_product and @id_order = order_id
	if (@count = 0)
		begin
			insert into Orders_detail (order_id, product_id, amount_product, price_product) 
			values (@id_order, @id_product, @amount, (select product_price from Products where product_id = @id_product));	
		end
	else
		begin
			update Orders_detail set amount_product = amount_product + @amount where product_id = @id_product and @id_order = order_id
		end
end
GO
/****** Object:  StoredProcedure [dbo].[getCartNotPay]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getCartNotPay]
@user_mail nvarchar(100)
as
begin
	Select o.order_id, p.product_id, p.product_name,  d.amount_product, p.product_price, a.user_name, a.user_address, a.user_phone, o.order_discount_code
	from Orders_detail d 
	join Orders o on d.order_id = d.order_id 
	join Products p on p.product_id = d.product_id
	join Account a on a.user_mail = o.user_mail
	where o.user_mail = @user_mail and o.order_status = 0
end
GO
/****** Object:  StoredProcedure [dbo].[getProductById]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getProductById]
@product_id int
as
begin
	Select * from Products where product_id = @product_id
end
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetProducts]
@u int,
@v int
as
begin
 SELECT p.product_id ,p.product_name, p.product_des, p.product_price, p.product_img_source, p.product_type, p.product_brand FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) as row 
  FROM Products p
 ) p WHERE p.row >= @u and p.row <= @v
end
GO
/****** Object:  StoredProcedure [dbo].[GetProductsType]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetProductsType]
@u int,
@v int,
@b varchar(50)
as
begin
 SELECT p.product_id ,p.product_name, p.product_des, p.product_price, p.product_img_source, p.product_type, p.product_brand FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) as row 
  FROM Products p where p.product_type = @b
 ) p WHERE p.row >= @u and p.row <= @v
end

GO
/****** Object:  StoredProcedure [dbo].[searchProduct]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[searchProduct]
@keyword nvarchar (255)
as
begin
	Select * from Products where product_name like '%'+@keyword+'%'  
end
GO
/****** Object:  StoredProcedure [dbo].[storePayBill]    Script Date: 17/04/2023 11:13:15 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[storePayBill]
@order_id int
as
begin
	Update Orders set order_status = 1, total_price = t.total from(
	Select o.order_id, SUM(d.price_product*d.amount_product) as total from Orders o left join Orders_detail d  on d.order_id = o.order_id 
	where o.order_id = @order_id and o.order_status = 0
	group by  o.order_id) as t where Orders.order_id = t.order_id
end
GO
create proc UpdateOrderList
@orderID int, @productID int, @status int
as
begin
	IF @status = 0
		begin
			declare @count int = (Select amount_product from Orders_detail where order_id = @orderID and product_id = @productID);
			If @count >= 1
				Begin
					Update Orders_detail set amount_product = amount_product - 1 where order_id = @orderID and product_id = @productID;
					Set @count = (Select amount_product from Orders_detail where order_id = @orderID and product_id = @productID);
					If @count = 0
					begin
						delete Orders_detail where order_id = @orderID and product_id = @productID
					end
				end
		end
	else if @status = 1
		begin
			Update Orders_detail set amount_product = amount_product + 1 where order_id = @orderID and product_id = @productID
		end
	else if @status = 2
		begin
			delete Orders_detail where order_id = @orderID and product_id = @productID
		end
end
go
create proc sp_getPaging
@pageNumber int, @productDisplayNumber int
as
begin
	Select TOP(@productDisplayNumber) * from Products where product_id IN (
	Select product_id from Products
	except
	Select TOP(@productDisplayNumber*(@pageNumber-1)) product_id from Products)
end
go
create proc getAccount
@umail varchar(100), @pass varchar(64)
as
begin
	Select count(*) as count from Account where user_mail = @umail and password = @pass
end
go
create proc getRole
@umail varchar(100)
as
begin
	Select  account_role , user_name from Account where user_mail = @umail
end
go
*/
--22-04-2023 09:35
alter proc [dbo].[getCartNotPay]
@user_mail nvarchar(100)
as
begin
	Select o.order_id, p.product_id, p.product_name,  d.amount_product, p.product_price, a.user_name, a.user_address, a.user_phone, o.order_discount_code
	from Orders_detail d 
	join Orders o on o.order_id = d.order_id 
	join Products p on p.product_id = d.product_id
	join Account a on a.user_mail = o.user_mail
	where o.user_mail = @user_mail and o.order_status = 0
end
GO
create proc registryAccount
@umail varchar(100), @upass varchar(64), @uname nvarchar(50), @address nvarchar(255), @uphone varchar(10), @urole int
as
begin
	insert  into  Account values (@umail, @upass, @urole, @uname, @address, @uphone);
end
go
select * from Account
Select * from Products
Select * from Orders
Select * from Orders_detail
delete Orders_detail
exec createBill 'duongdt@fpt.com.vn' , 10, 1, '1011'
exec getAccount 'duongdt@fpt.com.vn', '12345678'
exec getRole 'duydt@fpt.com.vn'
exec getRole 'duongdt@fpt.com.vn'
Update Orders set total_price = 0 where order_id = 10
exec UpdateOrderList 20,6,1
exec getCartNotPay 'duongdt@fpt.com.vn'
exec sp_getPaging 2,7
Select count(*) as count  from Products
Select count(*) as count from Account where user_mail = 'duongdt@fpt.com.vn'
insert Products values (N'iPhone Xr 128GB', N'Màn hình: 6.1", Liquid Retina  HĐH: iOS 12  CPU: Apple A12 Bionic 6 nhân  RAM: 3 GB, ROM: 128 GB  Camera: 12 MP, Selfie: 7 MP',17.99, N'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-red-600x600.jpg','cellphone','apple')