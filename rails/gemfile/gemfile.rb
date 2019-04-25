# Пессимистическое ограничение диапазона версий

gem 'nokogiri', '~> 1.0'   gem 'nokogiri', '>= 1.0', '< 2.0'
gem 'nokogiri', '~> 1.5.0' gem 'nokogiri', '>= 1.5.0', '< 1.6.0'
gem 'nokogiri', '~> 1.5.3' gem 'nokogiri', '>= 1.5.3', '< 1.6.0'

# Доступные операторы
# RubyGems предоставляет полный набор операторов версий,
# которые позволяют вам указать, с какими версиями гема
# может работать ваше приложение. Если вы не используете
# оператор и просто используете номер версии, вы привязываете
# свое приложение к этой конкретной версии, это сокращение
# от использования оператора равенства (=).

# Вот список операторов, поддерживаемых в RubyGems:
Operator  Meaning
=         Equal to (default)
!=        Not equal to
>         Greater than
<         Less than
>=        Greater than or equal to
<=        Less than or equal to
~>        Pessimistically greater than or equal to
