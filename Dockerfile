# Используем официальный образ Go для сборки
FROM golang:1.23.2 AS build

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . .

# Скачиваем зависимости и компилируем проект
RUN go mod tidy
RUN go build -o hello-world

# Используем минимальный образ для запуска
FROM alpine:latest

# Устанавливаем рабочую директорию для финального контейнера
WORKDIR /app

# Копируем скомпилированное приложение из предыдущего контейнера
COPY --from=build /app/hello-world .

# Устанавливаем команду по умолчанию для запуска приложения
CMD ["./hello-world"]
