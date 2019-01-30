package com.lzj.security.repository;

import com.lzj.security.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    /**
     * 根据用户名称查找对应的角色
     * @param userId
     * @return
     */
    List<Role> findRolesByUserId(Long userId);
}
