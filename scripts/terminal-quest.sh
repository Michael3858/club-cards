#!/usr/bin/env bash
# 終端機尋寶：建一個「臺科校園」資料夾，跟著線索用指令走完，練 pwd/ls/cd/cat/mkdir/touch/echo/mv/rm
# 用法：bash scripts/terminal-quest.sh            （建在 ~/terminal-quest）
#       bash scripts/terminal-quest.sh <資料夾>
# 重跑一次 = 重新開始
set -euo pipefail

Q="${1:-$HOME/terminal-quest}"

if [ -e "$Q" ]; then
  if [ -f "$Q/.terminal-quest" ]; then
    rm -rf "$Q"
  else
    echo "$Q 已經存在而且不是尋寶資料夾，換一個名稱吧"
    exit 1
  fi
fi

mkdir -p "$Q"/campus/{gate,library/floor1,library/floor2,cafeteria,dorm}
touch "$Q/.terminal-quest"

cat > "$Q/README.txt" <<'EOF'
歡迎來到臺科尋寶！跟著線索走，每一步都要用指令完成。

1. 打 pwd，看看你現在在哪
2. 打 ls，看看這裡有什麼
3. 打 cd campus 走進校園，再打 ls 看看
4. 走到校門：cd gate，然後打 cat clue.txt 看第一個線索

迷路了？打 pwd 看自己在哪，cd ~/terminal-quest 回到起點
EOF

cat > "$Q/campus/gate/clue.txt" <<'EOF'
線索 1：下一個線索在圖書館二樓（library/floor2）

提示：
- cd .. 是回到上一層
- 也可以一次走好幾層：cd ../library/floor2
- 打字打到一半按 Tab，會自動補完名字
EOF

echo "這層只有書，線索在樓上喔" > "$Q/campus/library/floor1/clue.txt"

cat > "$Q/campus/library/floor2/clue.txt" <<'EOF'
線索 2：這一層藏了一個「看不到」的檔案

試試 ls -a（a = all，連隱藏檔都列出來）
名字開頭是 . 的檔案就是隱藏檔，找到後用 cat 打開它
EOF

cat > "$Q/campus/library/floor2/.secret.txt" <<'EOF'
密碼是：NTUST2026（記下來）

下一站：餐廳 cafeteria
從這裡要怎麼走？提示：要先往上退兩層
EOF

for i in $(seq -w 1 30); do
  echo "今日菜單 $i：雞腿飯" > "$Q/campus/cafeteria/menu-$i.txt"
done
echo "學生證：有人掉在這裡，請送到宿舍" > "$Q/campus/cafeteria/lost-card.txt"
echo "這是垃圾" > "$Q/campus/cafeteria/trash.txt"

cat > "$Q/campus/cafeteria/clue.txt" <<'EOF'
線索 3：餐廳好亂！

1. 有人掉了學生證 lost-card.txt，檔案太多不好找？
   打 cat lost 然後按 Tab，看看會發生什麼
2. 把學生證送去宿舍（移動檔案）：
   mv lost-card.txt ../dorm/
3. 地上有垃圾 trash.txt，刪掉它：
   rm trash.txt
   注意：rm 刪掉就沒了，不會進資源回收筒！
4. 打 clear 清一下畫面，然後去宿舍 dorm 看下一個線索
EOF

cat > "$Q/campus/dorm/clue.txt" <<EOF
線索 4：報到！

1. 建一個資料夾：mkdir checkin
2. 走進去：cd checkin
3. 把密碼寫進一個用你英文名字命名的檔案：
   echo 密碼 > 你的名字.txt      （例如 echo NTUST2026 > william.txt）
4. 用 cat 確認內容
5. 回到起點：cd ~/terminal-quest（或 cd $Q）
6. 打 ls -R 看整張校園地圖
7. 檢查有沒有過關：bash check.sh
EOF

cat > "$Q/check.sh" <<'EOF'
#!/usr/bin/env bash
cd "$(dirname "$0")"
pass=0
ok()  { echo "✓ $1"; pass=$((pass+1)); }
bad() { echo "✗ $1"; }

[ -f campus/dorm/lost-card.txt ] && [ ! -f campus/cafeteria/lost-card.txt ] \
  && ok "學生證送到宿舍了" || bad "學生證還沒送到宿舍（mv）"
[ ! -f campus/cafeteria/trash.txt ] \
  && ok "垃圾清掉了" || bad "餐廳還有垃圾（rm）"
[ -d campus/dorm/checkin ] \
  && ok "報到資料夾建好了" || bad "宿舍裡還沒有 checkin 資料夾（mkdir）"
if ls campus/dorm/checkin/*.txt >/dev/null 2>&1 && grep -q "NTUST2026" campus/dorm/checkin/*.txt; then
  ok "密碼寫對了"
else
  bad "checkin 裡還沒有寫著正確密碼的 .txt 檔（echo 密碼 > 名字.txt）"
fi

echo
if [ "$pass" -eq 4 ]; then
  echo "🎉 全部過關！你已經會用終端機了"
else
  echo "過了 $pass / 4 關，看看上面的 ✗ 再試試"
fi
EOF

echo "尋寶地圖建好了！開始："
echo
echo "  cd \"$Q\""
echo "  cat README.txt"
