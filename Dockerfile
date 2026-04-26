FROM debian:12

RUN apt update && apt install -y ffmpeg nginx

# Pasta do stream
RUN mkdir -p /var/www/hls

# Copiar config nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta
EXPOSE 10000

# Rodar tudo
CMD service nginx start && \
    ffmpeg -re -i SUA_LISTA.m3u8 \
    -c copy -f hls \
    -hls_time 10 -hls_list_size 5 \
    /var/www/hls/stream.m3u8
