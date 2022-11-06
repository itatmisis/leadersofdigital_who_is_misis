# leadersofdigital_who_is_misis
## Кто такие эти ваши мисис
___

**Database requirements:** PostreSQL with extension postgis
postgresql@14
```
$ <packet-manager> install postgis
psql: CREATE EXTENSION postgis;
```
`.env` file in project-root directory must contain:
```
DB_URL="postgresql://<username>:<password>>@<host>:<port>/<db-name>"
```

`properties_config.json` содержит формализованное описание свойств некоторых сущностей, которые можно получить по /api/get_property
```json
{
  "Здесь будет формат файла.....": "скоро"
}
```