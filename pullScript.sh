#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.github.env"

: "${GITHUB_TOKEN:?GITHUB_TOKEN이 설정되지 않았습니다}"
: "${GITHUB_REPO:?GITHUB_REPO가 설정되지 않았습니다}"
: "${TARGET_DIR:?TARGET_DIR이 설정되지 않았습니다}"
: "${BRANCH:?BRANCH가 설정되지 않았습니다}"

AUTH=$(printf "x-access-token:%s" "$GITHUB_TOKEN" | base64 -w0)

git_auth() {
    git -c http.extraHeader="Authorization: Basic $AUTH" "$@"
}

REPO_NAME=$(basename "$GITHUB_REPO")
REPO_URL="https://github.com/${GITHUB_REPO}.git"
REPO_PATH="${TARGET_DIR}/${REPO_NAME}"

mkdir -p "$TARGET_DIR"

clone_repo() {
    echo "[INFO] 저장소 클론 중..."

    git_auth clone \
        --branch "$BRANCH" \
        "$REPO_URL" \
        "$REPO_PATH"

    echo "[OK] 클론 완료"
}

update_repo() {
    echo
    echo "[INFO] 저장소가 이미 존재합니다."
    echo "1) git fetch"
    echo "2) git pull"
    echo "3) fetch + reset --hard origin/$BRANCH"
    echo "4) 종료"
    echo

    read -rp "선택 [1-4]: " choice

    cd "$REPO_PATH"

    case "$choice" in
        1)
            git_auth fetch
            ;;
        2)
            git_auth pull
            ;;
        3)
            git_auth fetch
            git reset --hard "origin/${BRANCH}"
            ;;
        4)
            exit 0
            ;;
        *)
            echo "[ERROR] 잘못된 선택"
            exit 1
            ;;
    esac

    echo "[OK] 완료"
}

if [[ ! -d "$REPO_PATH/.git" ]]; then
    clone_repo
else
    update_repo
fi
