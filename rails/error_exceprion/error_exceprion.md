Не делать так:

```rb
begin
  …
rescue => e
  …
end
# Тут спасаются ошибки всех классов унаследованных от Exception, даже
# SignalException, SyntaxError…
```

Делать так:

```rb
begin
  …
rescue StandardError => e
  …
end
```
