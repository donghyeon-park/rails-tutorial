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

### 초기화
`rails new store` 명령어를 통해 프로젝트를 생성합니다.

#### 트러블 슈팅
1. `uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger (NameError)
`  
    
    [스택오버플로우](https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror)에서, 구버전 사용으로 인해 문제가 발생했음을 확인했습니다.
    
    `concurrent-ruby` 의존성을 v.1.3.4 로 다운그레이드 하여 문제를 해결했습니다. 
