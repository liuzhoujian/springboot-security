package com.lzj.security.config;

import com.lzj.security.component.CustomPasswordEncoder;
import com.lzj.security.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //定制请求的授权规则
        http.authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers("/level1/**").hasRole("VIP1")
                .antMatchers("/level2/**").hasRole("VIP2")
                .antMatchers("/level3/**").hasRole("VIP3");

        //开启自动配置的登录功能 效果：如果没有登录，就会来到登录页面
        http.formLogin().loginPage("/userlogin").usernameParameter("user").passwordParameter("pwd").loginProcessingUrl("/userlogin");
        //使用默认的登录页
        //1、默认的登录页面 GET 方式/login来到登录页
        //2、默认的登录页 POST 方式 /login 表示提交账号(表单属性name="username")和密码(表单属性name="password")
        //2、重定向到/login?error表示登录失败

        //使用自己定制的登录页
        //1、loginPage中的路径，表示要跳转到自己制定的登录页面路径
        //2、usernameParameter passwordParameter可以指定表单中用户名和密码提交时的参数名，默认username和password
        //3、自己定制的登录页面中提交路径,默认是loginPage中指定的路径; 可以使用loginProcessingUrl指定，处理登录请求的路径

        //开启自动配置的注销功能
        http.logout().logoutSuccessUrl("/"); //注销成功后返回首页
        //1、访问/logout 表示注销，清空session
        //2、注销成功会返回/login?logout页面

        //开启记住我功能
        //1、登录成功后，将cookie发送给浏览器保存，以后访问页面带上这个cookie，只要通过检查就可以免登录
        //2、点击注销功能，就会删除cookie
        //tokenValiditySeconds设置cookie从存储时间
        http.rememberMe().rememberMeParameter("remember").tokenValiditySeconds(1000);


        http.csrf().disable(); //开启了CSRF保护，关闭即可 403 Forbidden
    }

    //在内存中：定义认证规则
   /* @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //在内存中配置用户名、密码、角色
        auth.inMemoryAuthentication().withUser("admin").password("admin").roles("VIP1", "VIP2")
        .and()
        .withUser("lisi").password("123").roles("VIP2")
        .and()
        .withUser("zhangsan").password("123").roles("VIP3")
        .and()
        .passwordEncoder(new CustomPasswordEncoder()); //There is no PasswordEncoder mapped for the id "null" 解决方案
    }*/


    /**
     * 生成定义一个PasswordEncoder的Bean，配置加密方式，这里生成BCryptPasswordEncoder的Bean对象
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 生成定义一个PasswordEncoder的Bean，配置明文加密方式，自定义CustomPasswordEncoder
     */
    @Bean
    public PasswordEncoder myPasswordEncoder() {
        return new CustomPasswordEncoder();
    }

    /**
     * 生成一个自定义的UserDetailsServiceImpl的Bean，交给Spring IOC容器
     */
   @Bean
   public UserDetailsService userDetailsService() {
       return new UserService();
   }

    /**
     * 通过数据库定制认证规则
     * @param auth
     * @throws Exception
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService()). //用户认证
                passwordEncoder(myPasswordEncoder()); //使用加密验证
    }
}
