# 專案組第一次聚會：學生講義

> 今天的目標：**把你的名片放上 [名片牆](https://williamtsou.github.io/club-cards/)**。
> 過程中你會學到終端機、Git，還有業界工程師每天在用的開發流程。

做完一段，在電腦上貼 🟩 便利貼；卡住了就貼 🟥，助教會過來。
指令和快捷鍵不用背，忘了就查 [速查表](cheatsheet.md)。

文中的 `你的帳號` 都要換成**你的 GitHub 帳號**（`github.com/` 後面那串）。

---

## 0. 課前準備（在家做好）

- [ ] 註冊 GitHub 帳號，**完成 email 驗證**
- [ ] 安裝 Git
  - Windows：到 https://git-scm.com 下載，一路按 Next（會一起裝好 Git Bash）
  - Mac：打開「終端機」，輸入 `git --version`，跳出視窗就按安裝
- [ ] Mac 另外安裝 GitHub CLI：https://cli.github.com
- [ ] 安裝 VS Code，並在延伸模組裝好 **Live Server**
- [ ] Windows：VS Code 按 `Ctrl+Shift+P` → 輸入 `Terminal: Select Default Profile` → 選 **Git Bash**
- [ ] 準備好 w10 的名片（`index.html` + 頭像，頭像 500KB 以下、檔名用英文）
  - 沒做完也沒關係，今天可以用範本

---

## 1. 環境設定（10 分鐘）

### 1-1 打開終端機

VS Code 按 ``Ctrl + ` ``（Esc 下面那顆），下方會出現終端機。

✅ 檢查：Windows 的提示符號裡要有 `MINGW64`。如果看到的是 `PS C:\...`，代表開成 PowerShell 了，回去做課前準備的最後一步。

### 1-2 告訴 Git 你是誰（只要做一次）

```bash
git config --global user.name "你的名字"
git config --global user.email "你註冊 GitHub 的 email"
git config --global pull.rebase false
git config --global core.editor "code --wait"
```

✅ 檢查：`git config --global --list` 看得到你的名字和 email。

### 1-3（只有 Mac）登入 GitHub

```bash
gh auth login
```

依序選：`GitHub.com` → `HTTPS` → `Yes` → `Login with a web browser`，照畫面在瀏覽器登入。

> Windows 不用做這步，第一次 push 時會自動跳出瀏覽器叫你登入。

### 先懂三件事

1. **Git** 是存檔工具，在你的電腦裡；**GitHub** 是放專案的網站
2. 存檔分兩步：`git add`（把要存的東西放進信封）→ `git commit`（封口寄出，留下紀錄）
3. 今天會有三個地方：

| 名字 | 是什麼 | 你能改嗎 |
| --- | --- | --- |
| `upstream` | 老師的 repo（williamtsou/club-cards） | ❌ 只能用 PR 申請 |
| `origin` | 你 fork 到自己帳號的那一份 | ✅ |
| 你的電腦 | clone 下來的那一份 | ✅ |

---

## 2. 終端機尋寶（15 分鐘）

終端機就是「用打字操作資料夾」。資料夾是一間一間房間：

- `pwd`：我現在在哪？
- `ls`：這個房間有什麼？
- `cd 房間名`：走進去；`cd ..`：退回上一層

### 2-1 下載尋寶地圖

```bash
cd ~
curl -O https://williamtsou.github.io/club-cards/scripts/terminal-quest.sh
bash terminal-quest.sh
```

### 2-2 開始尋寶

```bash
cd ~/terminal-quest
cat README.txt
```

接下來**跟著每個線索走**，每一關都會教你一個新指令。

兩個超好用的技巧：

- 名字打一半按 **`Tab`**，會自動補完
- 按 **`↑`**，會叫出上一個指令

### 2-3 過關檢查

走到宿舍、照最後一個線索做完後：

```bash
cd ~/terminal-quest
bash check.sh
```

✅ 看到 🎉 全部過關，貼 🟩！

> ⚠️ `rm` 刪掉的東西**不會進資源回收筒**，用之前想清楚。
> ⚠️ 終端機裡的 `Ctrl + C` 是「中斷」，不是複製。

---

## 3. 新人報到：完整開發流程（25 分鐘）

> **情境**：你今天是新公司的新人工程師。技術主管（老師）交給你第一個任務：**把自己加進團隊頁**。
> 你要照公司規定的流程來：**開 Issue → Fork → 開分支 → commit → push → 開 PR → 等審核**。

先看老師示範一次，再自己做。對照下面的步驟，每做完一步就打勾。

### Step 1：開 Issue（說你要做什麼）

- [ ] 打開 https://github.com/williamtsou/club-cards → **Issues** → **New issue**
- [ ] 選 **「新增名片」** 模板，填好送出
- [ ] 記下 Issue 編號（標題後面的 `#數字`），等一下會用到：`#____`

### Step 2：Fork（複製一份到你的帳號）

- [ ] 在 repo 首頁右上角按 **Fork** → **Create fork**
- [ ] 網址變成 `github.com/你的帳號/club-cards` 就對了

### Step 3：Clone 你的 fork 到電腦

```bash
cd ~
git clone https://github.com/你的帳號/club-cards.git
cd club-cards
```

> ⚠️ 網址裡是**你的帳號**，不是 williamtsou。clone 錯的話，等一下 push 會出現 403。

### Step 4：接上老師的 repo

```bash
git remote add upstream https://github.com/williamtsou/club-cards.git
git remote -v
```

✅ 檢查：看到 `origin`（你的帳號）和 `upstream`（williamtsou）各兩行。

### Step 5：開分支

```bash
git switch -c add-你的帳號
```

> 為什麼要開分支？main 是正式版，大家都不能直接改。你在自己的分支上改，改好再申請合併。

### Step 6：放進你的名片

```bash
code .
```

在 VS Code 裡：

- [ ] 在 `cards/` 底下建一個資料夾，名稱是**你的帳號（全小寫）**
- [ ] 把你的 w10 名片（`index.html` + 頭像）放進去
  - 沒有名片？在終端機打 `cp -r cards/_template cards/你的帳號`，再改裡面的文字
- [ ] 打開根目錄的 `index.html`，找到 `<ul class="members">`，**依帳號字母順序**插入一行：

```html
<li><a href="cards/你的帳號/">你的名字</a></li>
```

- [ ] 在 `index.html` 上按右鍵 → **Open with Live Server**，點你的名字，確認進得去你的名片

### Step 7：存檔（commit）

```bash
git status
```

看到紅字 = 改了但還沒放進信封。

```bash
git add .
git status
```

變綠字 = 放進信封了。

```bash
git commit -m "feat: 新增 你的名字 的名片"
git log --oneline
```

✅ 檢查：`git log` 最上面那行是你剛剛的訊息。

### Step 8：Push 到你的 fork

```bash
git push -u origin add-你的帳號
```

> Windows 第一次會跳出瀏覽器叫你登入 GitHub，登入後就會繼續。

### Step 9：開 PR（申請合併）

- [ ] 回到 `github.com/你的帳號/club-cards`，按黃色框的 **Compare & pull request**
- [ ] 確認方向：**左邊是 `williamtsou/club-cards` `main`，右邊是 `你的帳號/club-cards` `add-你的帳號`**
- [ ] 照模板填好，在「對應的 Issue」寫 `Closes #你的Issue編號`
- [ ] 把自我檢查的框框勾一勾，按 **Create pull request**

### Step 10：等審核

- [ ] 去看看別人的 PR，在 **Files changed** 留一句話（問問題、給建議都可以），練習當審核者
- [ ] 老師審核通過、合併之後：
  - 你的 Issue 會**自動關閉**（因為你寫了 `Closes #`）
  - 1～2 分鐘後，[名片牆](https://williamtsou.github.io/club-cards/) 上會出現你的名字 🎉

### Step 11：合併後，同步最新版

```bash
git switch main
git pull upstream main
git push origin main
```

> 下一個任務要**開新分支**，不要沿用舊的。

---

## 4. 衝突練習（15 分鐘）

> **情境**：同事比你先合併了，而且改到跟你一樣的地方。輪到你的 PR 時，GitHub 說 **This branch has conflicts**。

### 4-1 先懂衝突是什麼

兩個人在同一本筆記的**同一行**寫了不同的字，Git 不敢亂猜，就把兩個版本都列出來請你選：

```
<<<<<<< HEAD
你的版本
=======
別人的版本（已經在正式版上了）
>>>>>>> case1-theirs
```

**原則：後合併的人，負責把自己的修改接到最新的正式版上。**

### 4-2 建練習場

```bash
cd ~/club-cards
bash scripts/conflict-lab.sh
cd ~/conflict-lab
```

### 4-3 三種情況

| 情況 | 指令 | 正確解法 |
| --- | --- | --- |
| 1. 兩個人都新增到同一個位置（**必做**） | `git switch case1-mine` → `git merge case1-theirs` | **兩個都留**，照字母排好 |
| 2. 同一行改成不同意思 | `git switch case2-mine` → `git merge case2-theirs` | **不要自己決定**，在 PR 留言問對方，討論後選一個 |
| 3. 別人改了規則（`cards/` 改名成 `people/`） | `git switch case3-mine` → `git merge case3-theirs` | **用別人的新版**，把你那行也改成 `people/` |

每一種都這樣解：

1. 打開有衝突的檔案（VS Code 會標紅色）
2. 點上方的 **Accept Current / Incoming / Both**，或自己手動改
3. **刪掉** `<<<<<<<`、`=======`、`>>>>>>>` 三種標記
4. 收尾：

```bash
git add .
git commit
```

（會跳出 VS Code 讓你看訊息，直接關掉那個分頁就會完成）

### 4-4 先練習「反悔」

做情況 1 之前，先故意放棄一次：

```bash
git merge case1-theirs
git merge --abort
git status
```

✅ 檢查：`git status` 顯示一切乾淨，就像沒發生過。**解壞了隨時可以這樣重來。**

### 4-5 你的 PR 真的有衝突？

剛好跟別人插在同一個位置，就會遇到真的衝突：

```bash
cd ~/club-cards
git switch add-你的帳號
git pull upstream main
```

用情況 1 的方法解完，然後 `git add .` → `git commit` → `git push`，PR 會自動更新。

---

## 5. 課後任務

到 [Issues](https://github.com/williamtsou/club-cards/issues) 看任務，在想做的 Issue 底下**留言「我來做」**就是認領。

| 任務 | 內容 | 必做？ |
| --- | --- | --- |
| 1 | 名片 PR 被合併，名片牆上看得到你 | ✅ |
| 2 | 在至少一個別人的 PR 留下有內容的審核留言 | ✅ |
| 3 | conflict-lab 三種情況都解過一次 | ✅ |
| 4 | 認領一個功能 Issue（搜尋框、Dark Mode、卡片排版…），完成並開 PR | 選做 |

每個新任務都從這裡開始：

```bash
cd ~/club-cards
git switch main
git pull upstream main
git switch -c feat/Issue編號-簡短描述
```

---

## 卡住了？

1. 先打 `git status`，它通常會告訴你下一步
2. 打 `pwd`，確認你在對的資料夾
3. 查 [速查表的「常見錯誤」](cheatsheet.md#常見錯誤)
4. 貼 🟥，舉手

| 最常見的狀況 | 解法 |
| --- | --- |
| push 出現 403 / Permission denied | clone 到老師的 repo 了，要 clone **你自己的 fork** |
| 不小心在 main 上 commit | `git switch -c add-你的帳號`，commit 會跟著到新分支 |
| 跳進一個奇怪的畫面出不來 | 按 `Esc`，打 `:q!` 再按 Enter；或按 `q` |
| 網頁上出現 `<<<<<<<` | 解衝突忘了刪標記，刪掉再 commit 一次 |
