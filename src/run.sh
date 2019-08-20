SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

# テスト用ファイル作成
echo "create table users(id integer primary key, name text, class text);
insert into users(name,class) values('Yamada','A');
insert into users(name,class) values('Suzuki','B');
insert into users(name,class) values('Tanaka','A');" > create_0.sql

# デフォルト
sqlite3 :memory: \
".read create_0.sql" \
"select * from users;"

# `.mode`
for mode in ascii column csv html insert line list quote tabs tcl; do
	echo "-----.mode ${mode}"
	sqlite3 :memory: \
	".read create_0.sql" \
	".mode ${mode}" \
	"select * from users;"
done

# list + .separator
sqlite3 :memory: \
".read create_0.sql" \
".mode list" \
".separator '-' ';'" \
"select * from users;"

# insert テーブル名あり
sqlite3 :memory: \
".read create_0.sql" \
".mode insert users" \
"select * from users;"

# insert テーブル名なし
sqlite3 :memory: \
".read create_0.sql" \
".mode insert" \
"select * from users;"

# column + .width
sqlite3 :memory: \
".headers on" \
".mode column" \
".width -4 -30" \
"select 1 as id, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' as alphabet;"

