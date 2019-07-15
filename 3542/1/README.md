- Параметр `--top`, показывает количество гемов согласно рейтинга:

```bash
ruby top_gems.rb --file=gems.yml --top=2
```

- Параметр `--name`, выводит все Gems согласно рейтинга в имя которых входит заданное слово:

```bash
ruby top_gems.rb --file=gems.yml --name=active
```

- Параметр `--file` [REQUIRED], который является путем к yml файлу, содержащему список имен гемов:

```bash
ruby top_gems.rb --file=gems.yml
```
