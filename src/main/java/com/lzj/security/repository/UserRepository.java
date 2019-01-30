package com.lzj.security.repository;

import com.lzj.security.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    /**
     * 根据用户姓名查找用户
     * @param userName
     * @return
     */
    User findByName(String userName);
}
