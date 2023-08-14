
# onemm UI

### 일미리

일미리는 집 근처 1mm 앞에도 있는 의외의 반려동물 동반장소를 찾을 수 있는 서비스입니다. 

다양한 가게에 리뷰를 남기거나 좋아요를 누르고, 나만의 테마리스트를 만들어서 유저들과 공유할 수 있습니다.
  
<br>


### 🎆 주요기능과 실행화면
  
<br>

### 1) 리뷰  


<img src="https://github.com/PaperRing/onemm_backend/assets/63621849/a5cb72d0-cf38-45e5-ab40-a53ffa50f96d"  width="300"  height="644"/> 

<br>

가게에 대한 리뷰를 작성하고 별점을 줄 수 있는 기능입니다. 서버 사용 비용을 고려해 한장만 올릴 수 있도록 제한했습니다. 
  - 리뷰 `C`  `R`  `U`  `D`
  
  - 이미지 `C` `R`
  
  - 이미지는 보통 사이즈가 크기때문에 백엔드 서버로 동시요청을 하면 유저경험이 안좋을 수 있고, 속도적인 측면에서 장점이 있기때문에 클라이언트에서 S3로 업로드 가능한 PresignedUrl을 사용했습니다.
  
  - 리뷰 이미지는 유저가 리뷰를 삭제 하더라도 가게 대표 이미지로 사용하기때문에 삭제하지 않았습니다.

<br>


### 2) 테마리스트

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/735dc090-9bff-40be-84b1-c78cfcad4ff6"  width="300"  height="644"/>


<br>

자신이 좋아하는 가게들을 테마리스트로 만들어 공유하는 기능입니다. 테마리스트에는 가게(아이템)을 추가하거나 삭제할 수 있습니다. 유저들은 마음에 드는 테마리스트를 좋아요를 눌러서 찜한장소에 저장할 수 있습니다.

  

- 테마리스트 `C` `R` `U` `D`

- 아이템 `C` `D`

<br>
  


### 3) 팔로우

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/ffc7bdbb-8ad4-4397-a5c3-409d5fd90ccd"  width="300"  height="644"/>

  

<br>

팔로우 기능입니다. 다른 유저들의 팔로우와 팔로워도 확인 할 수 있습니다.

  

- 팔로우 `C` `D`

단순한 구조로 팔로우 정보를 저장하고 호출할 수 있도록 설계했습니다.

- 나의 id는 23 이라고 가정하겠습니다.

`login_id`(로그인한 유저 id) , `follow_id` (팔로우하는 유저 id) 두 가지 데이터만 저장하고, 호출시에 내가 팔로우한 유저는 `login_id`가 나의 아이디인 23, 나를 팔로우한 유저는 `follow_id`가 23인 `login_id`를 찾도록 로직을 설계했습니다.

<br>
  


### 4) 좋아요

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/ae02fe71-3a9e-4e97-8036-3241ebf8483b"  width="300"  height="644"/>

  
<br>

마음에 드는 장소와 테마리스트를 좋아요해 찜한 장소에서 확인할 수 있습니다.

<br>

  

### 5) 로그인

  
<br>
<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/b1c338bd-60cb-4dd4-b644-9cd90a6b00c9"  width="300"  height="644"/>

  

- Firebase는 Flutter 친화적이며 기본적으로 social login 기능을 제공하고 있기때문에 사용하기 편리해서 Firebase Authentication을 사용했습니다.

- 하지만 유저 정보를 변경하거나 추가하는데에는 한계가 있고, 추가로 관리해야 하는 유저정보가 있었기때문에 기본 생성되는 uid와 로그인한 e-mail, 닉네임, 프로필 사진을 DB에 별도로 저장해서 관리했습니다.

  

  <br>


### 6) 검색

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/a92a63ea-1d01-41c0-b76c-b3ae2de47d11"  width="300"  height="644"/>

  
<br>
지역명, 가게명으로 검색할 수 있습니다.

  

- 검색 `C`  `R`  `D`

<br>


### 7) 회원정보

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/89e36ede-d4d8-4dd7-88ce-4d2e7cf4cac0"  width="300"  height="644"/>

  

<br>
닉네임과 프로필 사진을 변경할 수 있습니다. 탈퇴하면 모든 리뷰와 테마리스트 회원정보가 삭제됩니다.

  

- 회원정보 관리 `R` `U` `D`

 <br>
 


### 8) 유저 차단/ 리뷰 신고

  

<img  src="https://github.com/PaperRing/onemm_backend/assets/63621849/5c0e7feb-f249-4442-8456-ccc82a4e8beb"  width="300"  height="644"/>

  

<br>
- 다른 유저를 차단하면 리뷰, 테마리스트 등을 볼 수 없습니다.

- 리뷰를 신고하면 검토후에 삭제합니다.

<br>
<br>
<br>
<br>
<br>



