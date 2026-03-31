FROM metal3d/xmrig:latest
# Các tham số chạy trực tiếp trong CMD
ENTRYPOINT ["xmrig"]
CMD ["-o", "gulf.moneroocean.stream:10128", "-u", "ĐỊA_CHỈ_VÍ_CỦA_ANH", "-p", "railway-test", "--donate-level=1"]
