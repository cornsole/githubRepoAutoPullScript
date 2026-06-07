# githubRepoAutoPullScript

## 빠른시작
#### 1. 키 발급
[Setting](https://github.com/settings/profile) > Developer Settings > Personal access tokens > Tokens (classic) > Generate new token > New personal access token (classic) 들어간후

원하는 Note와 Expiration(키 만료) 를 설정

Select scopes에서 repo 클릭
<img width="1000" height="474" alt="image" src="https://github.com/user-attachments/assets/8263a0fc-7eec-4b91-81fe-e2d25f3ec2d3" />
나머지는 scopes는 선택하지 않아도 됩니다

이후 스크롤을 하고 Generate token을 클릭해줍니다

이후 생성된 
`ghp_0000000000000000000000` 와 같은 키를 복사하고 매모장과 같은곳에 잠시 붙여넣기해둡니다 
(여기서 복사를 해두지않으면 새로운키를 다시 발급받아야합니다)

#### 2. 스크립트 복사
스크립트가 필요한 폴더에서 다음 명령을 실행하여 스크립트를 다운받습니다
```
curl -L -O "https://raw.githubusercontent.com/cornsole/githubRepoAutoPullScript/refs/heads/main/pullScript.sh" && curl -L "https://raw.githubusercontent.com/cornsole/githubRepoAutoPullScript/refs/heads/main/.github.env.example" -o .github.env
```

#### 3. env파일 수정
원하는 파일 편집기(ex.vim,nano)로 .github.env를 열어 다음과 같이 적어줍니다
```
GITHUB_TOKEN=ghp_0000000000000000000000
// ㄴ> 아까 적어뒀던 key를 다음과같이 적어줍니다

GITHUB_REPO=cornsole/githubRepoAutoPullScript
// ㄴ> 원하는 repo를 다음과 같이 적어줍니다

TARGET_DIR=/home/console/myProjectFolder
// ㄴ> 다음과같이 dir을 적어줍니다
// 이렇게 적으면 myProject안에 git clone이 됩니다

BRANCH=main
// ㄴ> 브런치 세팅해줍니다
```

#### 4. 스크립트 권한 세팅
```
chmod +x pullScript.sh
```

#### 5. 스크립트 실행
```
./pullScript.sh
```
실행후 진행

## 설명

##### 최소 실행시: git clone 진행

##### 저장소가 이미 존재할경우
\> git fetch
\> git pull
\> 로컬 저장소 초기화후 동기화 진행 

셋중 선택가능
