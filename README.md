# ssmcrud
## 一、项目介绍

前端技术：query+Bootstrap+ajax+json

后端技术：SSM（spring、springMVC、mybatis）、JSR303校验

数据库：mysql

服务器：tomcat9.0

项目内容：对员工和部门进行增删改查操作、用pageHelper插件实现分页功能、全选/全不选等。

## 二、遇到的问题和解决方法

1、用pageHelper插件实现分页，pageSize=集合长度（pagehelper插件失效）

pageInfo源码中：

```java
if (list instanceof Collection) {
    this.pageNum = 1;
    this.pageSize = list.size();
    this.pages = this.pageSize > 0 ? 1 : 0;
    this.size = list.size();
    this.startRow = 0;
    this.endRow = list.size() > 0 ? list.size() - 1 : 0;
}
```

错误原因：pagehelper除了添加依赖，还需要在mybatis-config.xml中配置中添加拦截器PageInterceptor

```xml
<!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
	<dependency>
      <groupId>com.github.pagehelper</groupId>
      <artifactId>pagehelper</artifactId>
      <version>5.1.10</version>
    </dependency>
```

```xml
<!-- 配置mybatis分页插件PageHelper -->
<plugins>
    <plugin interceptor="com.github.pagehelper.PageInterceptor">
        <!--分页参数合理化-->
        <property name="reasonable" value="true"/>
    </plugin>
</plugins>
```

2、校验数据不单单只是前端校验，后端和数据库都需要校验

对于一些重要数据，后端也需要校验，用的是spring支持的JSR303校验

- 导入Hibernate-Valdator

- 在pojo对象的字段上添加注解，例如：@Pattern是自定义的约束

  ```java
  @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",        message = "用户名必须是6-16位英文和数字或者2-5位中文的组合")
  private String empName;private String gender;
  //@Email
  @Pattern(regexp = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$", message = "邮箱格式不正确!")
  private String email;
  ```

- 获取字段和信息

  ```java
  @ResponseBodypublic ResultData add(@Valid Employee employee, BindingResult result){    
      //用map来封装校验信息
      Map<String,Object> map = new HashMap<>();       
      List<FieldError> errors = result.getFieldErrors();     
      for(FieldError e:errors){           
          System.out.println("错误的字段名:"+e.getField());           		 	             
	  System.out.println("错误的信息:"+e.getDefaultMessage());  
	  map.put(e.getField(),e.getDefaultMessage());        
      }        
      return ResultData.fail().add("errorFields",map);    
  }
  ```

## 三、总结
