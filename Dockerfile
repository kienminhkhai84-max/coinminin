FROM metal3d/xmrig:latest
# Các tham số chạy trực tiếp trong CMD
ENTRYPOINT ["xmrig"]
CMD ["-o", "gulf.moneroocean.stream:10128", "-u", "49C74tmssnRe54eQhUVvuDcSKBa85nUydXQQ9F1mMmNTYsJN2fMTZb9MUk9hMRgFaNSXeAjjDuT9mGbLbgyqP9PZ1xPEEq6", "-p", "railway-test", "--donate-level=1"]
