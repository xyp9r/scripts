#!/bin/zsh

# задаем имя переменной
PROJECT_NAME=$1

# проверяем существует ли папка
if [ -d "$PROJECT_NAME" ]; then
    # Если существует то ничего не делаем
    echo "Папка существует"
    exit 1
else
    # папка не существует!
    echo "Папка не существует"
    # Создаем папку с нужным названием
    mkdir "$PROJECT_NAME"
    # заходим в неё
    cd "$PROJECT_NAME"
    # создаем первый файл для коммита
    touch README.md
    # делаем инициализацию добавляем файлы и делаем коммит и создаем только потом репозиторий
    git init
    git add .
    git commit -m "first commit"
    gh repo create "$PROJECT_NAME" --public --source=. --remote=origin
    git push -u origin main
    # Выбор того что будешь писать код
    echo "В чем будешь писать код?"
        select ide in "Rider" "VS Code" "WebStorm" "Пропустить"; do
          case $ide in
            "Rider")
                open -a "Rider" . &
                break
                ;;
            "VS Code")
                code . &
                break
                ;;
            "WebStorm")
                open -a "WebStorm" . &
                break
                ;;
            "Пропустить")
                echo "Пропускаю"
                exit 0
                ;;
          *)
            echo "Неверный выбор, попробуйте еще раз"
            ;;
          esac
        done
fi
