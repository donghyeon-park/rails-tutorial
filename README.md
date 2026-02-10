# Rails Tutorial

[공식 가이드](https://guides.rubyonrails.org/getting_started.html)를 기준으로 작성했습니다. 

## 주요 철학

Rails는 Django과 유사하게, 최선의 방식이 있다고 가정하고, 이를 유도하는 방식으로 설계되어 있다.

그래서 'Rails의 방식'을 따라가는 경우 생산성이 오르지만,  
다른 언어의 습관을 유지하는 경우 좋은 경험이 아닐 수 있다. 

Rails는 아래의 두가지 핵심 원칙을 포함한다.

- DRY, Don't Repeat Yourself  
- CoC, Convention over Configuration
---

## Rails 앱 생성

### 참고사항
> 해당 프로젝트는   
rosetta 기반 애플 실리콘 환경 및  
`rails v6.1.5.1`, `ruby v2.7.8`  
버전을 사용하고 있습니다.  
이로 인해 기본 설정에서 차이가 있을 수 있습니다. 

---
### 초기화
`rails new store` 명령어를 통해 프로젝트를 생성합니다.

#### 트러블 슈팅
1. `uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError)`
    
    [스택오버플로우](https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror)에서, 구버전 사용으로 인해 문제가 발생했음을 확인했습니다.  
    `concurrent-ruby` 의존성을 v.1.3.4 로 다운그레이드 하여 문제를 해결했습니다. 

---

### 모델 생성

`bin/rails generate model Product name:string` 명령을 통해,  
string 타입의 name이라는 속성을 가진 Product 테이블을 생성할 수 있습니다.

실행 시 터미널에 로그가 나타나는데,  
```shell
Running via Spring preloader in process 81082
      invoke  active_record
      create    db/migrate/20260210070110_create_products.rb
      create    app/models/product.rb
      invoke    test_unit
      create      test/models/product_test.rb
      create      test/fixtures/products.yml
```
아래의 세 가지가 만들어진 것을 확인할 수 있습니다.
1. db/migrate 폴더 내에 마이그레이션 파일
2. app/models 폴더 내에 ActiveRecord model 파일
3. test, fixture 파일  

---
