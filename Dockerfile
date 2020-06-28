FROM node:slim
LABEL maintainer="Utku Kaynar <https://buck.ai>"

WORKDIR /

RUN apt-get update && \
    apt-get install -y git && \
    git clone --depth 1 https://github.com/buck-ai/vroom-frontend.git && \
    cd /vroom-frontend && \
    npm install && \
    apt purge -y git && \
    apt autoremove --purge -y && \
    apt clean && \
    apt-get autoremove -y && \
    apt-get autoclean

COPY panel.js /vroom-frontend/src/controls/panel.js
COPY index.html /vroom-frontend/index.html

COPY api.js /vroom-frontend/src/config/api.js

WORKDIR /vroom-frontend

EXPOSE 9966

CMD ["npm", "run", "serve"]
