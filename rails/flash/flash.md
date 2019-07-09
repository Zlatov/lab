## controller

```
flash.notice = 'Мне не спится, нет огня;'
flash.notice = 'Мне не спится, нет огня'
flash[:alert] = 'Всюду мрак и сон докучный.'
flash[:alert] = 'Всюду мрак и сон докучный'
flash.delete :recaptcha_error
```

## view

_layout_:

```
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
