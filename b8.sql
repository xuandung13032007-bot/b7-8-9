-- Các câu lệnh SQL sẽ được thực thi trên cơ sở dữ liệu 'sakila' có sẵn.

-- Bảng chính sẽ làm việc là 'customer'.
INSERT INTO customer (store_id, first_name, last_name, email, address_id)
VALUES (2, 'ANNA', 'HILL', 'ANNA.HILL@sakilacustomer.org', 5);
set sql_safe_updates ='0';
UPDATE customer
SET email = REPLACE(email, '@sakilacustomer.org', '@sakilacustomer.com')
WHERE first_name = 'JENNIFER';
UPDATE customer
SET active = 0
WHERE customer_id = 25;
/*
Soft delete (đánh dấu là không hoạt động) tốt hơn hard delete (xóa vĩnh viễn) vì:

1. Bảo toàn lịch sử giao dịch:
   - Khách hàng có thể đã từng thuê DVD, thanh toán, hoặc tham gia chương trình khuyến mãi.
   - Xóa vĩnh viễn sẽ khiến dữ liệu lịch sử bị mất, gây khó khăn cho việc báo cáo và phân tích.

2. Tránh mất mát dữ liệu do thao tác nhầm:
   - Nếu lỡ DELETE nhầm, dữ liệu rất khó hoặc không thể phục hồi.
   - Soft delete an toàn hơn vì chỉ đánh dấu, vẫn có thể khôi phục lại được.

3. Hỗ trợ phân tích hành vi khách hàng:
   - Biết khách hàng nào ngừng hoạt động giúp doanh nghiệp đánh giá churn rate, xây chiến lược giữ chân khách hàng.

4. Ràng buộc khóa ngoại:
   - Bảng customer liên kết với payment, rental, inventory.
   - DELETE có thể gây lỗi hoặc làm hỏng cấu trúc dữ liệu nếu không xử lý cascade cẩn thận.
*/
