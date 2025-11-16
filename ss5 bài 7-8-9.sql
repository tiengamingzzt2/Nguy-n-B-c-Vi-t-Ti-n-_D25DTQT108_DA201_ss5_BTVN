------ bài 7 ------

SELECT customer_id, amount, payment_date
FROM sakila.payment
WHERE payment_date > '2005-08-01'
AND amount > 9.00
ORDER BY amount DESC;

SELECT payment_id, customer_id, staff_id, amount
FROM sakila.payment
WHERE amount = 0.00
OR (staff_id = 1 AND amount > 10.00)
ORDER BY customer_id ASC;

/*
PHÂN TÍCH & NHẬN ĐỊNH

1. Khách hàng VIP:
   - Các giao dịch có giá trị trên 9.00 và sau 2005-08-01 cho thấy nhóm khách hàng chi tiêu mạnh 
     thường thực hiện thanh toán với giá trị cao.
   - Việc sắp xếp kết quả theo amount DESC giúp quản lý nhanh chóng xác định được những khách hàng 
     chi tiêu nhiều nhất, hỗ trợ cho việc lập danh sách khách hàng VIP hoặc triển khai chương trình ưu đãi.

2. Giao dịch bất ngờ (amount = 0.00):
   - Giao dịch 0.00 có thể xuất hiện do chương trình khuyến mãi, cho thuê miễn phí, đổi trả, 
     hoặc lỗi hệ thống khi xử lý thanh toán.
   - Quản lý cửa hàng cần theo dõi kỹ loại giao dịch này vì chúng có thể ảnh hưởng đến doanh thu 
     và phản ánh vấn đề trong hệ thống thanh toán.

3. Hiệu suất nhân viên (staff_id = 1):
   - Việc nhân viên số 1 xử lý nhiều giao dịch với giá trị cao có thể là dấu hiệu năng suất tốt 
     hoặc cho thấy họ được phân bổ vào ca/bộ phận có giao dịch lớn.
   - Để đánh giá chính xác, cần thêm thông tin: tổng số giao dịch mỗi nhân viên, doanh số trung bình, 
     thời gian làm việc, số ca trực, và mức độ hài lòng của khách hàng khi giao dịch với nhân viên đó.
*/

------ bài 8 -------

INSERT INTO sakila.customer (store_id,first_name,last_name,email,address_id,active )
VALUES (2,'ANNA','HILL','ANNA.HILL@sakilacustomer.org', 5, 1);

UPDATE sakila.customer
SET email = REPLACE(email, '@sakilacustomer.org', '@sakilacustomer.com')
WHERE first_name = 'JENNIFER';

UPDATE sakila.customer
SET active = 0
WHERE customer_id = 25;

/*
SOFT DELETE vs HARD DELETE

1. Giữ lại lịch sử giao dịch:
   - Trong các hệ thống kinh doanh như Sakila, khách hàng đã từng thuê phim, trả phim, và thanh toán.
   - Nếu xóa vĩnh viễn bằng DELETE, các bảng liên quan (payment, rental) có thể bị mất mối quan hệ
     hoặc gây lỗi khóa ngoại (foreign key).
   → Soft delete giúp giữ toàn bộ lịch sử giao dịch để phục vụ báo cáo và kiểm tra sau này.

2. Hỗ trợ khôi phục tài khoản:
   - Nhiều khách hàng quay lại sau thời gian dài ngừng sử dụng.
   - Nếu dữ liệu bị xóa vĩnh viễn, phải tạo lại từ đầu và mất dữ liệu cũ.
   → Soft delete cho phép kích hoạt lại chỉ bằng một UPDATE.

3. Phục vụ phân tích dữ liệu:
   - Dữ liệu khách hàng không hoạt động vẫn rất quan trọng cho phân tích churn rate (tỷ lệ rời bỏ),
     phân khúc khách hàng, và dự đoán doanh thu.
   - Nếu xóa cứng, doanh nghiệp mất dữ liệu quý giá phục vụ BI & Data Analytics.

Vì vậy, trong nhiều hệ thống, soft delete được ưu tiên vì tính an toàn, ổn định, và giá trị phân tích.
*/

------ bài 9 -------

SELECT film_id, title, rating, length, rental_rate
FROM sakila.film
WHERE (rating = 'PG' OR rating = 'G')
AND length > 100
AND rental_rate >= 2.99
ORDER BY rental_rate DESC;

UPDATE sakila.film
SET rental_rate = rental_rate / 2
WHERE (rating = 'PG' OR rating = 'G')
AND length > 100
AND rental_rate >= 2.99;

/*
PHÂN TÍCH RỦI RO — HOÀN TÁC — CẢI TIẾN
1. RỦI RO LỚN NHẤT KHI UPDATE KHÔNG ĐÚNG WHERE:
   - Nếu chạy UPDATE mà quên mệnh đề WHERE, hoặc viết sai điều kiện,
     hệ thống sẽ cập nhật TẤT CẢ các bộ phim trong bảng film.
   - Điều này có thể khiến toàn bộ giá thuê bị giảm 50%, gây thiệt hại
     lớn về doanh thu, làm sai lệch các chiến dịch khuyến mãi và
     phá vỡ cấu trúc định giá của toàn bộ cửa hàng.
   - Hậu quả:
       • Mất doanh thu ngay lập tức.
       • Phát sinh lỗi định giá trên website/cửa hàng.
       • Ảnh hưởng đến báo cáo tài chính và kế hoạch marketing.
2. KẾ HOẠCH HOÀN TÁC (ROLLBACK PLAN)
   Nếu phát hiện sai sót sau khi chạy UPDATE ở Nhiệm vụ 2,
   có thể hoàn tác bằng cách nhân đôi lại rental_rate
   (giả sử chỉ giảm đúng 50% và chưa có thay đổi nào khác):
   -- LỆNH HOÀN TÁC:
   UPDATE sakila.film
   SET rental_rate = rental_rate * 2
   WHERE (rating = 'PG' OR rating = 'G')
   AND length > 100
   AND rental_rate < 2.99; 
   -- Lưu ý: rental_rate < 2.99 sau giảm → dùng điều kiện này để chọn đúng dòng.
   Lý do cần kế hoạch hoàn tác:
   - Đảm bảo an toàn dữ liệu trong các chiến dịch cập nhật hàng loạt.
   - Cho phép khôi phục nhanh chóng để giảm thiểu tác động kinh doanh.
   - Là yêu cầu bắt buộc trong quy trình quản trị dữ liệu chuyên nghiệp
     để đảm bảo tính chính xác và minh bạch.
3. ĐỀ XUẤT CẢI TIẾN QUY TRÌNH
   Để chiến dịch trong tương lai an toàn hơn:
   - Tạo thêm cột original_rental_rate để lưu trữ giá gốc:
       ALTER TABLE film ADD COLUMN original_rental_rate DECIMAL(4,2);
   - Trước khi UPDATE, sao chép giá gốc:
       UPDATE film SET original_rental_rate = rental_rate;
   - Kiểm thử bằng SELECT trước khi chạy UPDATE chính.
   - Yêu cầu phê duyệt từ bộ phận quản lý trước khi chạy lệnh UPDATE.
   - Sử dụng giao dịch (BEGIN; COMMIT; ROLLBACK;) nếu hệ thống hỗ trợ.
*/


