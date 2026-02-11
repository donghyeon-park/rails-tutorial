# Rails Tutorial

[공식 가이드](https://guides.rubyonrails.org/getting_started.html)를 기준으로 작성했습니다. 

## 주요 철학

Rails는 Django과 유사하게, '최선의 방식이 이미 정해져 있다'고 가정하고,  
그 방식으로 개발자를 유도하는 방식으로 설계된 프레임워크입니다.

그래서 'Rails다운 방식'을 따라가는 경우 생산성이 높아지지만,  
다른 언어나 프레임워크의 습관을 유지하는 경우 불편한 경험을 하게 될 수 있습니다.

Rails의 설계 철학은 아래의 두가지 핵심 원칙을 포함합니다.

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

## 모델 생성

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

> 모델의 이름은 단수형으로 작성합니다.  
> 인스턴스화된 모델은 하나의 레코드를 나타내기 때문입니다.

모델을 설정하고 나면, `bin/rails db:migrate`  
명령을 통해 db에 변경 사항을 적용시킬 수 있습니다.

> 실제 데이터베이스 테이블 이름은 복수형으로 생성됩니다.  
> 테이블은 모든 레코드를 가지고 있기 때문입니다.

---

### 콘솔

`bin/rails console` 명령어를 통해,  
복잡한 테스트 설정 없이 Rails 환경을 로드하고,  
ruby 코드를 실행하며 상호작용할 수 있습니다. 

```shell
irb(main):006:0> Product.create name: "밥"
  TRANSACTION (0.1ms)  begin transaction
  Product Create (1.4ms)  INSERT INTO "products" ("name", "created_at", "updated_at") VALUES (?, ?, ?)  [["name", "밥"], ["created_at", "2026-02-10 07:37:12.584102"], ["updated_at", "2026-02-10 07:37:12.584102"]]
  TRANSACTION (1.8ms)  commit transaction
=> #<Product id: 3, name: "밥", created_at: "2026-02-10 07:37:12.584102000 +0000", updated_at: "2026-02-10 07:37:12.584102000 +0000">
```
위와같이 irb 세션에서 모델을 생성,조회,수정하는 등,  
실제 애플리케이션 환경과 동일한 조건에서 코드를 실험해볼 수 있습니다.

---

### CRUD

```ruby

# name = "밥" 을 가진 Product객체를 생성하고, 
# product 변수에 할당합니다.
product = Product.new(name: "밥")
# => #<Product id: nil, name: "밥", created_at: nil, updated_at: nil>

# product를 저장합니다.
product.save
# => #<Product id: 5, name: "김치", created_at: "2026-02-10 07:52:21.469821000 +0000", updated_at: "2026-02-10 07:52:21.469821000 +0000">

# create를 통해 할당 없이 바로 생성할 수도 있습니다. 
Product.create(name: "국")

# 전체를 조회합니다.
Product.all
# => #<ActiveRecord::Relation [#<Product id: 1, name: "밥", created_at: "2026-02-10 07:56:23.351629000 +0000", updated_at: "2026-02-10 07:56:23.351629000 +0000">, #<Product id: 2, name: "국", created_at: "2026-02-10 07:56:29.458875000 +0000", updated_at: "2026-02-10 07:56:29.458875000 +0000">]>

# 특정 조건을 조회합니다.
Product.where(name: "밥")
Product.where(name: "김")
# 없는 값을 조회 시 에러가 아닌 빈 레코드를 반환합니다.
# => #<ActiveRecord::Relation []>

# order 는 쿼리 뒤에 붙어서 정렬을 지원합니다. 
Product.where(name: "밥").order(name: :asc)

# Product.all.order(name: :desc) 와 동일합니다.
Product.order(name: :desc)

# id를 기준으로 하나의 레코드만 찾고 싶은 경우 find를 사용합니다.
product = Product.find(1)
# update 를 통해 값을 수정할 수 있습니다. 
product.update(name: "면")

# 객체의 인스턴스에 재할당하고, save하는 방식으로도 update를 구현할 수 있습니다.
product.name = "고기"
product.save

# destroy를 통해 delete 할 수 있습니다.
product.destroy
```

---

### Validations

```ruby
# app/models/product.rb
class Product < ApplicationRecord
  validates :name, 
            presence: true, 
            uniqueness: true, 
            length: { minimum: 2, maximum: 8 }
end
```
위의 형태로 컬럼에 not null, unique, length 제약사항을 추가할 수 있다. 

다시 콘솔에서,
```ruby
product = Product.new
product.save # false

product.name = "밥"
product.save # false, "Name is too short (minimum is 2 characters)"

product.name = "김밥"
product.save # true

Product.create(name: "김밥") # false, Name has already been taken
Product.create(name: "국밥") # true

Product.create(name: "알리오올리오파스타") # false, "Name is too long (maximum is 8 characters)"
```

## 요청

### Routes

`route`는 HTTP 메서드와 요청 path 쌍으로 이루어져 있고,  
응답에 어떤 컨트롤러에서, 어떤 행동을 취할지를 명시합니다.

```ruby
# config/routes.rb 
Rails.application.routes.draw do
  get "/products", to: "products#index"
end
```
해당 코드에서는 example.org/products 로 들어오는 GET 요청을 products#index 로 전달하겠다는 의미입니다. 
Rails는 이를 해석해 ProductsController의 index를 호출하고,  
그 결과로 적절한 응답을 클라이언트에게 반환합니다. 

GET 외에도 다양한 사용법이 있습니다.
```ruby
# config/routes.rb 
Rails.application.routes.draw do
  get "/products", to: "products#index"

  # post 메서드로 해당 주소에 요청 시, ProductsController.create를 호출하고, 응답을 반환합니다.
  post "/products", to: "products#create"

  # :id 형태로 파라미터를 받아올 수 있습니다. 
  get "/products/:id", to: "products#show"

  # patch 메서드로 id 파라미터를 가지고 ProductsController.update를 호출하고, 응답을 반환합니다. 
  patch "/products/:id", to: "products#update"

  # put 메서드로 id 파라미터를 가지고 ProductsController.update를 호출하고, 응답을 반환합니다.
  put "/products/:id", to: "products#update"

  # delete 메서드로 id 파라미터를 가지고 ProductsController.destroy를 호출하고, 응답을 반환합니다.
  delete "/products/:id", to: "products#destroy"

  # 이 외에도 자주 쓰이는 코드입니다.
  get "/products/new", to: "products#new"
  get "/products/:id/edit", to: "products#edit"
end
```

위의 코드들을 각 모델들을 다룰 때마다 작성하는 것은 번거로우므로,  
Rails는 이를 위해 숏컷을 만들어 두었습니다. 
```ruby
Rails.application.routes.draw do
  resources :products
end
```
이 코드가 상기한 코드와 같은 동작을 합니다. 

`bin/rails routes` 를 통해 생성된 경로들을 확인할 수 있습니다. 
```shell
      Prefix Verb   URI Pattern                                                                                       Controller#Action
    products GET    /products(.:format)                                                                               products#index
             POST   /products(.:format)                                                                               products#create
 new_product GET    /products/new(.:format)                                                                           products#new
edit_product GET    /products/:id/edit(.:format)                                                                      products#edit
     product GET    /products/:id(.:format)                                                                           products#show
             PATCH  /products/:id(.:format)                                                                           products#update
             PUT    /products/:id(.:format)                                                                           products#update
             DELETE /products/:id(.:format)                                                                           products#destroy
```

그리고, `root "models#action"` 를 통해 루트 페이지의 액션을 재설정할 수 있습니다. 
```ruby
Rails.application.routes.draw do
  root "products#index"
  resources :products
end
```

---

### Controller

위에서 Controller 에 대한 설명을 했으나, 아직 파일이 존재하진 않는다.  
Controller 또한 Rails에서 제공하는 명령어를 통해 간편하게 만들 수 있다. 

`bin/rails generate controller Products index --skip-routes`  
해당 명령은 'Products의 컨트롤러를 만들어줘. index action을 포함하고, routes 를 같이 만들지는 마.' 라는 뜻입니다.

```shell
Running via Spring preloader in process 77876
      create  app/controllers/products_controller.rb
      invoke  erb
      create    app/views/products
      create    app/views/products/index.html.erb
      invoke  test_unit
      create    test/controllers/products_controller_test.rb
      invoke  helper
      create    app/helpers/products_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/products.scss
```
명령 실행 시 위와 같이 controller, erb, test-unit, helper, scss 파일을 각각 만들어줍니다.

---
#### READ

```ruby
# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
end
```

``` html
# views/products/index.html.erb
<h1>Products</h1>

<div id="products">
  <% @products.each do |product| %>
    <div>
      <%= product.name %>
    </div>
  <% end %>
</div>
```
위의 컨트롤러 코드에서는 `index` 액션에서 `Product`의 모든 레코드를 조회해 `@products` 인스턴스 변수에 담도록 설정했습니다.  
아래의 ERB 템플릿에서는 이 `@products`를 순회하면서, 각 `product`의 `name`을 출력하는 방식으로 화면을 구성합니다.

ERB 템플릿은 `<% %>` 를 통해 ruby 문법을 사용해서 뷰를 표현할 수 있습니다. 
```html
<h1>Products</h1>

<div id="products">
  <% @products.each do |product| %>
    <div>
      <a href="products/<%= product.id %>">
        <%= product.id %>번 제품: <%= product.name %>
      </a>
    </div>
  <% end %>
</div>
```
그래서 위와 같이 동적으로 하이퍼링크를 생성해 각 제품 페이지로 이동하게 만들 수 있습니다.

```html
<div id="products">
  <% @products.each do |product| %>
    <div>
      <%= link_to product.name, product_path(product.id)%>
    </div>
  <% end %>
</div>
```
그리고, `link_to` 헬퍼를 통해 더 깔끔하게 리팩토링 할 수 있습니다.

---
#### CREATE
create의 경우에도 동일한 방식으로 만들 수 있습니다 .

```html
<h1>New product</h1>

<%= form_with model: @product do |form| %>
  <div>
    <%= form.label :name %>: <%= form.text_field :name %>
  </div>

  <p>
    <%= form.submit %>
  </p>

<% end %>

<%= link_to "Cancel", products_path %>
```
형태로 뷰를 구성하고, 

```ruby
class ProductsController < ApplicationController
  # ...

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def product_params
      # 해당 코드는 6.1.5.1 버전에서 사용되지 않음
      # params.expect(product: [ :name ])
      params.require(:product).permit(:name)
    end
end
```
형태로 컨트롤러에 액션을 추가해 새 인스턴스를 만들 수 있습니다. 

---
#### 에러 처리

폼 입력 중 Validtion 등을 통해 백엔드 로직에서 에러가 발생하는 경우,  
`form.object.errors`에서 에러를 찾을 수 있습니다. 

이를 통해 에러가 발생하는 경우
```html
<%= form_with model: product do |form| %>
  <% if form.object.errors.any? %>
    <p class="error"><%= form.object.errors.full_messages.first %> </p>
  <% end %>
  ...
<% end %>
```
의 형태로 에러가 발생했을 시 화면에 표시해줄 수 있습니다. 

#### partial
Django/FE 에서의 component 개념과 동일합니다.

```html
# app/views/products/_form.html.erb

<%= form_with model: product do |form| %>
  <% if form.object.errors.any? %>
    <p class="error"><%= form.object.errors.full_messages.first %></p>
  <% end %>

  <div>
    <%= form.label :name %>: <%= form.text_field :name %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %>
```
로 선언해두면, 다른 뷰에서 해당 partial을 랜더링하는 방식으로 사용할 수 있습니다. 

```html
# app/views/products/new.html.erb

<h1>New product</h1>

<%= render "form", product: @product %>
<%= link_to "Cancel", products_path %>
```
해당 방식으로 랜더링할 수 있고, 이를 통해 자주 사용하는 형태의 경우 재사용할 수 있습니다.

---

#### UPDATE

partial로 공통 form 형태를 선언해 둔 덕분에,  
edit은 create와 거의 같은 형태로 구성할 수 있습니다. 

```html
<h1>Edit Product</h1>

<%= render "form", product: @product %>
<%= link_to "Cancel", @product %>
```

---

#### Before Actions
구현 중 `show`나 `edit`처럼  
레코드를 조회하고 변수에 할당하는 행위가 중복해서 일어납니다. 

중복을 줄이기 위해 `before_action` 을 사용할 수 있습니다. 

```ruby
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  # ...

  def show
  end

  def new
    @product = Product.new
  end

  # ...

  def edit
  end
  
  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    # ...
end
```
이전 코드에서 중복되었던  
`show`와 `edit`, 그리고 `update`의 `@product` 조회 로직을  
`set_product` 함수로 만들고, `before_actions` 정의를 통해  
해당 함수 호출 시 `set_product`를 먼저 실행하도록 설정할 수 있다.  

이는 python의 `decorator` 패턴과 유사하다.

---
