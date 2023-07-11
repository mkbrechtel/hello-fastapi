FROM python:3.11 AS packages

WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt


FROM node:18 as assets-node_modules

WORKDIR /app/assets
COPY assets/package.json assets/yarn.lock ./
RUN yarn install --frozen-lockfile


FROM packages as fastapi

COPY . .
CMD uvicorn main:app --host 0.0.0.0 --port 80

FROM assets-node_modules as assets

COPY . /app
RUN yarn build


FROM fastapi as production

COPY --from=assets /app/assets assets
