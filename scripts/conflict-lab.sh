#!/usr/bin/env bash
# 衝突練習場：在你的電腦上建一個獨立的小 repo，裡面有三種常見衝突可以練習
# 不會動到 club-cards，練壞了重跑一次就好
#
# 用法：bash scripts/conflict-lab.sh            （建在 ~/conflict-lab）
#       bash scripts/conflict-lab.sh <資料夾>
#
# 練習方式（三種都一樣）：
#   cd ~/conflict-lab
#   git switch case1-mine
#   git merge case1-theirs     ← 會出現 CONFLICT，開始解
#   解完：git add . && git commit
#   想重來：git merge --abort
set -euo pipefail

LAB="${1:-$HOME/conflict-lab}"

if [ -e "$LAB" ]; then
  if [ -f "$LAB/.conflict-lab" ]; then
    rm -rf "$LAB"
  else
    echo "$LAB 已經存在而且不是練習場，換一個資料夾名稱吧"
    exit 1
  fi
fi

mkdir -p "$LAB"
cd "$LAB"
git init -q -b main
touch .conflict-lab
git config user.name  "conflict-lab"
git config user.email "lab@example.com"

# ---------- 共同的起點 ----------
cat > case1-members.html <<'EOF'
<!-- 情況 1：兩個人都「新增」到同一個位置 -->
<ul>
  <li>amy</li>
  <li>kim</li>
</ul>
EOF

cat > case2-title.html <<'EOF'
<!-- 情況 2：兩個人把「同一行」改成不同的東西 -->
<h1>專案組名片牆</h1>
EOF

cat > case3-links.html <<'EOF'
<!-- 情況 3：別人的修改，讓你的寫法過時了 -->
<ul>
  <li><a href="cards/amy/">Amy</a></li>
  <li><a href="cards/kim/">Kim</a></li>
</ul>
EOF

git add .
git commit -qm "chore: 練習場起點"

# ---------- 情況 1：都是新增 ----------
git switch -qc case1-theirs main
sed -i.bak 's|  <li>amy</li>|  <li>amy</li>\
  <li>cat</li>|' case1-members.html
git commit -qam "feat: 新增 cat（別人先合併的）"

git switch -qc case1-mine main
sed -i.bak 's|  <li>amy</li>|  <li>amy</li>\
  <li>dan</li>|' case1-members.html
git commit -qam "feat: 新增 dan（你的）"

# ---------- 情況 2：同一行不同意思 ----------
git switch -qc case2-theirs main
sed -i.bak 's|<h1>專案組名片牆</h1>|<h1>大家的自我介紹</h1>|' case2-title.html
git commit -qam "style: 標題改成「大家的自我介紹」（別人先合併的）"

git switch -qc case2-mine main
sed -i.bak 's|<h1>專案組名片牆</h1>|<h1>NTUST 專案組成員</h1>|' case2-title.html
git commit -qam "style: 標題改成「NTUST 專案組成員」（你的）"

# ---------- 情況 3：別人改了規則 ----------
git switch -qc case3-theirs main
sed -i.bak 's|href="cards/|href="people/|g' case3-links.html
git commit -qam "refactor: 資料夾 cards/ 改名為 people/（別人先合併的）"

git switch -qc case3-mine main
sed -i.bak 's|  <li><a href="cards/amy/">Amy</a></li>|  <li><a href="cards/amy/">Amy</a></li>\
  <li><a href="cards/cat/">Cat</a></li>|' case3-links.html
git commit -qam "feat: 新增 Cat 的連結（你的）"

rm -f ./*.bak
git switch -q main

cat <<EOF

練習場建好了：$LAB

  cd "$LAB"

  情況 1（都是新增）：     git switch case1-mine && git merge case1-theirs
  情況 2（同一行不同意思）：git switch case2-mine && git merge case2-theirs
  情況 3（別人改了規則）：  git switch case3-mine && git merge case3-theirs

解完：git add . && git commit
重來：git merge --abort
全部重建：再跑一次這個腳本
EOF
