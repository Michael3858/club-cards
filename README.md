# 專案組名片牆

每位專案組成員的自介名片都放在這裡。這個 repo 也是我們練習 Git 與多人協作的地方。

- 網站：https://williamtsou.github.io/club-cards/
- 想加入名片：請看 [CONTRIBUTING.md](CONTRIBUTING.md)（Fork 流程）
- 上課講義：[docs/handout.md](docs/handout.md)
- 指令和快捷鍵忘了：請看 [docs/cheatsheet.md](docs/cheatsheet.md)

## 資料夾結構

```
club-cards/
├── index.html            # 目錄頁（名片牆）
├── cards/
│   ├── _template/        # 名片範本，還沒做 w10 名片的人可以複製這個
│   └── <GitHub帳號>/      # 每人一個資料夾
├── docs/
│   ├── handout.md        # 學生講義（上課照著做）
│   └── cheatsheet.md     # 指令與快捷鍵速查表
├── scripts/
│   ├── terminal-quest.sh # 終端機尋寶練習
│   ├── conflict-lab.sh   # 三種衝突練習場
│   └── setup-repo.sh     # 維護者用：一次設定 repo
└── .github/              # Issue 模板、PR 模板、CODEOWNERS
```

## 練習用腳本

在 Git Bash（Mac 用終端機）執行，不會動到這個 repo：

```bash
bash scripts/terminal-quest.sh   # 終端機尋寶，建在 ~/terminal-quest
bash scripts/conflict-lab.sh     # 衝突練習場，建在 ~/conflict-lab
```

## 在自己電腦上預覽

1. 用 VS Code 打開這個資料夾
2. 安裝延伸模組「Live Server」
3. 在 `index.html` 上按右鍵 → Open with Live Server

## 開發流程

**開 Issue → Fork → 開分支 → commit → push 到自己的 fork → 開 PR → 審核 → 合併**
細節都寫在 [CONTRIBUTING.md](CONTRIBUTING.md)。
