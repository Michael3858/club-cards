#!/usr/bin/env bash
# 一次設定好 repo：labels、合併方式、GitHub Pages、main 分支保護
# 用法：bash scripts/setup-repo.sh <owner>/<repo>
# 需要：gh 已登入（gh auth login），而且你是這個 repo 的 admin
set -euo pipefail

REPO="${1:?用法：bash scripts/setup-repo.sh <owner>/<repo>}"

echo "==> Labels"
gh label create card             --repo "$REPO" --color "1a73e8" --description "新增或修改名片" --force
gh label create feature          --repo "$REPO" --color "0e8a16" --description "新功能" --force
gh label create bug              --repo "$REPO" --color "d73a4a" --description "有東西壞掉了" --force
gh label create "good first issue" --repo "$REPO" --color "7057ff" --description "適合第一次參與" --force

echo "==> 合併方式：只留 Squash，合併後自動刪分支"
gh repo edit "$REPO" \
  --enable-squash-merge \
  --enable-merge-commit=false \
  --enable-rebase-merge=false \
  --delete-branch-on-merge \
  --enable-wiki=false

echo "==> GitHub Pages（main 分支根目錄）"
if gh api "repos/$REPO/pages" >/dev/null 2>&1; then
  echo "Pages 已經開啟，略過"
else
  gh api -X POST "repos/$REPO/pages" \
    -f "source[branch]=main" -f "source[path]=/" >/dev/null
fi

echo "==> main 分支保護：必須開 PR、至少 1 人 Approve、不能 force push"
gh api -X PUT "repos/$REPO/branches/main/protection" --input - >/dev/null <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "require_code_owner_reviews": false,
    "dismiss_stale_reviews": false
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON

echo "==> 完成"
gh api "repos/$REPO/pages" --jq '"網站：" + .html_url'
