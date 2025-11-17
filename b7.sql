 -- Các câu lệnh SQL sẽ được thực thi trên cơ sở dữ liệu 'sakila' có sẵn.

-- Ví dụ, để xem dữ liệu trong bảng payment:

-- SELECT * FROM sakila.payment LIMIT 10;
 SELECT 
    customer_id,
    amount,
    payment_date
FROM sakila.payment
WHERE payment_date > '2005-08-01' AND amount > 9.00
ORDER BY amount DESC;
 SELECT 
    payment_id,
    customer_id,
    staff_id,
    amount
FROM sakila.payment
WHERE amount = 0.00 OR (staff_id = 1 AND amount > 10.00)
ORDER BY customer_id ASC;
/*
------------ PHÂN TÍCH & NHẬN ĐỊNH ----------

1. Khách hàng VIP:
   - Các giao dịch trong Nhiệm vụ 1 có giá trị amount > 9.00 
     và chủ yếu tập trung vào nhóm khách hàng chi tiêu cao.
   - Việc sắp xếp theo amount DESC giúp nhanh chóng nhận diện 
     khách hàng nào chi tiêu nhiều nhất, hỗ trợ cho việc đề xuất 
     các chương trình tri ân, ưu đãi VIP ,...

2. Giao dịch Bất thường:
   - Các giao dịch amount = 0.00 có thể là:
       + Giao dịch khuyến mãi (free rental),
       + Bù trừ lỗi hệ thống,
       + Điều chỉnh thanh toán.
   - Đây là các giao dịch quan trọng cần được xem xét vì có thể ảnh hưởng 
     trực tiếp đến doanh thu,...

3. Hiệu suất Nhân viên:
   - Việc nhân viên staff_id = 1 là dấu hiệu tốt về hiệu suất làm việc.
   - Tuy nhiên, cần thêm dữ liệu để kết luận chắc chắn:
        + Tổng số giao dịch của nhân viên này,
        + Tỷ lệ lỗi giao dịch,
        + Số lượng khách hàng được phục vụ,
        + So sánh với các nhân viên khác.
   - Chỉ khi có thêm dữ liệu so sánh thì mới có thể đánh giá hiệu quả 
     của nhân viên một cách toàn diện.
*/
 
 
 