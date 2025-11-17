SELECT film_id, title, rating, length, rental_rate
FROM film
WHERE (rating = 'PG' OR rating = 'G') AND length > 100 AND rental_rate >= 2.99
ORDER BY rental_rate DESC;
set sql_safe_updates ='0';
UPDATE film
SET rental_rate = rental_rate / 2
WHERE (rating = 'PG' OR rating = 'G') AND length > 100 AND rental_rate >= 2.99;
/*
1. RỦI RO LỚN NHẤT KHI UPDATE SAI WHERE:

Nếu chạy câu lệnh UPDATE mà KHÔNG có mệnh đề WHERE,
hoặc WHERE sai điều kiện, hệ thống sẽ cập nhật TẤT CẢ
các bộ phim trong bảng film. Điều này dẫn đến:

- Tất cả giá thuê bị giảm 50% → doanh thu bị giảm nghiêm trọng.
- Gây ra biến động tài chính lớn cho công ty.

Đây là lỗi nghiêm trọng thường gặp trong thực tế
khi làm việc với UPDATE hàng loạt.

2. KẾ HOẠCH HOÀN TÁC (ROLLBACK PLAN):

Sẽ không cập nhật được

------------------------------------------------------
3. ĐỀ XUẤT CẢI TIẾN CHO CÁC CHIẾN DỊCH SAU:
------------------------------------------------------
- Tạo một cột mới: original_rental_rate để lưu giá gốc.
  UPDATE chỉ thay đổi rental_rate, nhưng original_rental_rate vẫn giữ nguyên.
  → Rollback dễ dàng và an toàn hơn.

Ví dụ:
ALTER TABLE film ADD COLUMN original_rental_rate DECIMAL(4,2);

- Trước khi giảm giá:
  UPDATE film SET original_rental_rate = rental_rate;

- Áp dụng transaction:
  START TRANSACTION;
    ... UPDATE ...
  COMMIT;

- Chạy SELECT xem trước kết quả trước khi UPDATE.
- Ghi log toàn bộ thay đổi để dễ theo dõi và audit sau này.


*/