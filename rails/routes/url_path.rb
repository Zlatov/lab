# Путь к статическим (не ассет) файлам в public:
Rails.public_path.join('robots.txt')

# УРЛ к файлам в public
root_url + 'robots.txt' # если быть точнее:
Rails.application.routes.url_helpers.root_url + 'robots.txt'
